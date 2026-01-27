#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"

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

echo "Done."
