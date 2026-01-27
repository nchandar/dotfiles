#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"
TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"
TPM_DIR="$TMUX_PLUGIN_DIR/tpm"
LINK_ONLY=false

if [ "${1:-}" = "--link-only" ]; then
  LINK_ONLY=true
fi

if [ "$LINK_ONLY" = false ]; then
  # 1) Install Homebrew if missing
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # 2) Install packages
  if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "Installing Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
  fi
fi

# 3) Symlink configs
mkdir -p "$CONFIG_DIR"

link() {
  src="$DOTFILES_DIR/config/$1"
  dest="$CONFIG_DIR/$1"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing $dest"
  else
    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
}

link nushell
link tmux
link ghostty
link hammerspoon
link starship.toml

# 4) Install tmux plugins (TPM)
if command -v git >/dev/null 2>&1; then
  mkdir -p "$TMUX_PLUGIN_DIR"
  if [ ! -d "$TPM_DIR" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi

  if [ ! -e "$HOME/.tmux.conf" ]; then
    cat > "$HOME/.tmux.conf" <<'EOF'
source-file ~/.config/tmux/tmux.conf
EOF
    echo "Created ~/.tmux.conf -> ~/.config/tmux/tmux.conf"
  fi

  if [ -x "$TPM_DIR/bin/install_plugins" ]; then
    TMUX_PLUGIN_MANAGER_PATH="$TMUX_PLUGIN_DIR" "$TPM_DIR/bin/install_plugins"
  fi
fi

echo "Done."
