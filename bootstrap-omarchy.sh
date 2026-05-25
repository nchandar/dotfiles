#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TMUX_PLUGIN_DIR="$CONFIG_DIR/tmux/plugins"
TPM_DIR="$TMUX_PLUGIN_DIR/tpm"
LINK_ONLY=false
INSTALL_DEPS=false
OS_NAME="$(uname -s)"

while [ $# -gt 0 ]; do
  case "$1" in
    --link-only)
      LINK_ONLY=true
      ;;
    --install-deps)
      INSTALL_DEPS=true
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--link-only] [--install-deps]"
      exit 1
      ;;
  esac
  shift
done

if [ "$OS_NAME" != "Linux" ]; then
  echo "bootstrap-omarchy.sh is Linux-only."
  echo "On macOS, use: bash bootstrap.sh"
  exit 1
fi

install_deps() {
  if command -v pacman >/dev/null 2>&1; then
    is_available() {
      pacman -Si "$1" >/dev/null 2>&1
    }

    pick_first_available() {
      for candidate in "$@"; do
        if is_available "$candidate"; then
          printf '%s\n' "$candidate"
          return 0
        fi
      done
      return 1
    }

    REQUIRED_PKGS=(
      nushell
      neovim
      tmux
      ghostty
      lazygit
      code
      nodejs
      go
      rust
      yazi
      opencode
      git
    )

    OPTIONAL_LABELS=("oh-my-posh" "carapace")
    OPTIONAL_CANDIDATES=("oh-my-posh oh-my-posh-bin" "carapace carapace-bin")

    INSTALL_PKGS=()
    MISSING_PKGS=()

    for pkg in "${REQUIRED_PKGS[@]}"; do
      if is_available "$pkg"; then
        INSTALL_PKGS+=("$pkg")
      else
        MISSING_PKGS+=("$pkg")
      fi
    done

    idx=0
    for label in "${OPTIONAL_LABELS[@]}"; do
      IFS=' ' read -r -a candidates <<< "${OPTIONAL_CANDIDATES[$idx]}"
      chosen="$(pick_first_available "${candidates[@]}" || true)"
      if [ -n "$chosen" ]; then
        INSTALL_PKGS+=("$chosen")
      else
        MISSING_PKGS+=("$label")
      fi
      idx=$((idx + 1))
    done

    if [ "${#INSTALL_PKGS[@]}" -gt 0 ]; then
      echo "Installing Omarchy/Linux dependencies via pacman..."
      if command -v sudo >/dev/null 2>&1; then
        sudo pacman -S --needed "${INSTALL_PKGS[@]}"
      else
        pacman -S --needed "${INSTALL_PKGS[@]}"
      fi
    fi

    if [ "${#MISSING_PKGS[@]}" -gt 0 ]; then
      echo "Some packages were not found in pacman repos: ${MISSING_PKGS[*]}"
      echo "Install missing ones via AUR/helper or manually, then rerun bootstrap if needed."
    fi
  else
    echo "No supported package manager detected for --install-deps."
    echo "Install dependencies manually, then rerun bootstrap."
  fi
}

mkdir -p "$CONFIG_DIR"

link() {
  src="$DOTFILES_DIR/config/$1"
  dest="$CONFIG_DIR/$1"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing $dest"
    return
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

echo "Linking config directories..."
link nushell
link tmux
link ghostty
link nvim
link oh-my-posh.omp.toml

# Claude Code config (~/.claude/)
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SRC="$DOTFILES_DIR/config/claude"
mkdir -p "$CLAUDE_DIR"
for f in CLAUDE.md settings.json statusline-command.sh; do
  dest="$CLAUDE_DIR/$f"
  src="$CLAUDE_SRC/$f"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing $dest"
  else
    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
done

# Workflow skills (https://github.com/nchandar/skills)
if [ ! -d "$HOME/skills" ]; then
  echo "Installing workflow skills..."
  git clone https://github.com/nchandar/skills "$HOME/skills"
  make -C "$HOME/skills" install-claude
else
  echo "Skipping existing ~/skills"
fi

if [ "$LINK_ONLY" = false ]; then
  if [ "$INSTALL_DEPS" = true ]; then
    install_deps
  fi

  # 1) Ensure tmux shim exists
  if [ ! -e "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
    cat > "$HOME/.tmux.conf" <<'EOF'
source-file ~/.config/tmux/tmux.conf
EOF
    echo "Created ~/.tmux.conf -> ~/.config/tmux/tmux.conf"
  fi

  # 2) Install TPM and plugins
  if command -v git >/dev/null 2>&1; then
    mkdir -p "$TMUX_PLUGIN_DIR"

    if [ ! -d "$TPM_DIR" ]; then
      echo "Installing TPM..."
      git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    fi

    if [ -x "$TPM_DIR/bin/install_plugins" ] && [ -d "$TMUX_PLUGIN_DIR" ]; then
      TMUX_PLUGIN_MANAGER_PATH="$TMUX_PLUGIN_DIR" "$TPM_DIR/bin/install_plugins"
    fi
  else
    echo "git not found; skipping TPM install"
  fi

  # 3) Sync Neovim plugins/tooling
  NVIM_BIN=""
  if command -v nvim >/dev/null 2>&1; then
    NVIM_BIN="$(command -v nvim)"
  elif [ -x /usr/bin/nvim ]; then
    NVIM_BIN="/usr/bin/nvim"
  elif [ -x /usr/local/bin/nvim ]; then
    NVIM_BIN="/usr/local/bin/nvim"
  elif [ -x /opt/nvim-linux-x86_64/bin/nvim ]; then
    NVIM_BIN="/opt/nvim-linux-x86_64/bin/nvim"
  fi

  if [ -n "$NVIM_BIN" ]; then
    "$NVIM_BIN" --headless "+Lazy sync" +qa
    "$NVIM_BIN" --headless "+TSUpdate" +qa
    echo "Neovim sync and TSUpdate completed."
  else
    echo "nvim not found; skipping Neovim sync."
  fi
fi

echo "Done."
