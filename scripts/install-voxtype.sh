#!/usr/bin/env bash
#
# Install or upgrade Voxtype on macOS.
#
# The peteonrails/voxtype Homebrew cask is stuck on the old bare-binary layout
# (0.7.5). Voxtype 1.0.1+ ships a real Voxtype.app bundle, so we install it
# straight from the GitHub release DMG instead.
#
# Idempotent: re-running only downloads when the installed version differs from
# the target (latest release, or $VOXTYPE_VERSION / --version X.Y.Z).
#
# Usage:
#   scripts/install-voxtype.sh [--version X.Y.Z] [--force]
#
# It does NOT grant the macOS TCC permissions (Accessibility, Input Monitoring,
# Microphone) — those need GUI clicks. Use the `setup-voxtype` skill for that,
# or grant them by hand in System Settings > Privacy & Security.
set -euo pipefail

REPO="peteonrails/voxtype"
APP="/Applications/Voxtype.app"
BUNDLE_ID="io.voxtype.daemon"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
CONFIG_SRC="$DOTFILES_DIR/config/voxtype/config.toml"
CONFIG_DEST="$HOME/Library/Application Support/voxtype/config.toml"

VERSION=""
FORCE=false
while [ $# -gt 0 ]; do
  case "$1" in
    --version) VERSION="${2:-}"; shift 2 ;;
    --version=*) VERSION="${1#*=}"; shift ;;
    --force) FORCE=true; shift ;;
    -h|--help) sed -n '3,17p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

if [ "$(uname -s)" != "Darwin" ]; then
  echo "install-voxtype: macOS only (on Linux use the distro package)." >&2
  exit 1
fi

log() { printf '\033[1;35m==>\033[0m %s\n' "$1"; }

installed_version() {
  [ -e "$APP/Contents/Info.plist" ] || return 0
  /usr/bin/defaults read "$APP/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || true
}

: "${VERSION:=${VOXTYPE_VERSION:-}}"
if [ -z "$VERSION" ]; then
  log "Resolving latest release of $REPO..."
  VERSION="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | sed -nE 's/.*"tag_name" *: *"v?([^"]+)".*/\1/p' | head -n1)"
fi
[ -n "$VERSION" ] || { echo "could not determine target version" >&2; exit 1; }

CURRENT="$(installed_version)"
log "Target: $VERSION   Installed: ${CURRENT:-none}"

if [ "$CURRENT" = "$VERSION" ] && [ "$FORCE" = false ]; then
  log "Voxtype.app already at $VERSION — skipping download."
else
  TMP="$(mktemp -d)"
  trap 'hdiutil detach "$TMP/mnt" >/dev/null 2>&1 || true; rm -rf "$TMP"' EXIT
  DMG_NAME="voxtype-$VERSION-macos-universal.dmg"
  BASE="https://github.com/$REPO/releases/download/v$VERSION"

  log "Downloading $DMG_NAME..."
  curl -fsSL -o "$TMP/$DMG_NAME" "$BASE/$DMG_NAME"

  log "Verifying checksum..."
  if curl -fsSL -o "$TMP/sums.txt" "$BASE/SHA256SUMS-macos.txt"; then
    want="$(grep " $DMG_NAME\$" "$TMP/sums.txt" | awk '{print $1}')"
    got="$(shasum -a 256 "$TMP/$DMG_NAME" | awk '{print $1}')"
    if [ -z "$want" ] || [ "$want" != "$got" ]; then
      echo "checksum mismatch for $DMG_NAME (want ${want:-?}, got $got)" >&2
      exit 1
    fi
    log "Checksum OK."
  else
    log "No SHA256SUMS-macos.txt in release — skipping checksum verification."
  fi

  mkdir -p "$TMP/mnt"
  hdiutil attach "$TMP/$DMG_NAME" -nobrowse -quiet -mountpoint "$TMP/mnt"

  if pgrep -qf "$APP/Contents/MacOS/"; then
    log "Quitting running Voxtype..."
    osascript -e "tell application id \"$BUNDLE_ID\" to quit" >/dev/null 2>&1 || true
    pkill -f "$APP/Contents/MacOS/" 2>/dev/null || true
    sleep 1
  fi

  log "Installing $APP ..."
  if [ -d "$APP" ]; then rm -rf "$APP"; fi
  cp -R "$TMP/mnt/Voxtype.app" /Applications/
  xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true

  hdiutil detach "$TMP/mnt" >/dev/null 2>&1 || true
fi

# Point /opt/homebrew/bin/voxtype (or /usr/local/bin) at the bundled binary.
for bindir in /opt/homebrew/bin /usr/local/bin; do
  if [ -d "$bindir" ] && [ -w "$bindir" ]; then
    ln -sfn "$APP/Contents/MacOS/voxtype-bin" "$bindir/voxtype"
    log "Linked $bindir/voxtype -> Voxtype.app"
    break
  fi
done

VOX="$APP/Contents/MacOS/voxtype-bin"

# Symlink the version-controlled config before setup so it isn't overwritten.
mkdir -p "$(dirname "$CONFIG_DEST")"
if [ -L "$CONFIG_DEST" ] && [ "$(readlink "$CONFIG_DEST")" = "$CONFIG_SRC" ]; then
  :
elif [ -e "$CONFIG_DEST" ] && [ ! -L "$CONFIG_DEST" ]; then
  mv "$CONFIG_DEST" "$CONFIG_DEST.bak.$(date +%s)"
  ln -sfn "$CONFIG_SRC" "$CONFIG_DEST"
  log "Linked config (backed up previous real file)."
else
  ln -sfn "$CONFIG_SRC" "$CONFIG_DEST"
  log "Linked $CONFIG_DEST -> $CONFIG_SRC"
fi

log "Downloading transcription model (if missing)..."
"$VOX" setup --download >/dev/null

log "Registering login item and launching daemon..."
"$VOX" setup app-bundle >/dev/null

log "Done. Voxtype $("$VOX" --version | awk '{print $2}') installed."
cat <<EOF

Grant these once in System Settings > Privacy & Security (the daemon can't
type or see the hotkey until you do):
  - Accessibility      -> enable Voxtype
  - Input Monitoring   -> enable Voxtype
  - Microphone         -> enable Voxtype (prompts on first FN press)

Then restart the daemon:  voxtype setup app-bundle --status
EOF
