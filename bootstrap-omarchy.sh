#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TMUX_PLUGIN_DIR="$CONFIG_DIR/tmux/plugins"
TPM_DIR="$TMUX_PLUGIN_DIR/tpm"
LINK_ONLY=false

if [ "${1:-}" = "--link-only" ]; then
  LINK_ONLY=true
fi

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

if [ "$LINK_ONLY" = false ]; then
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
