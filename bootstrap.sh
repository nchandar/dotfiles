#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"
TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
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
link aerospace
link nvim
link yazi
link oh-my-posh.omp.toml

# gitmux config (expects ~/.gitmux.conf)
if [ -e "$HOME/.gitmux.conf" ] || [ -L "$HOME/.gitmux.conf" ]; then
  echo "Skipping existing $HOME/.gitmux.conf"
else
  ln -s "$DOTFILES_DIR/config/gitmux.conf" "$HOME/.gitmux.conf"
  echo "Linked $HOME/.gitmux.conf -> $DOTFILES_DIR/config/gitmux.conf"
fi

# 3b) Claude Code config (~/.claude/)
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

# 3c) Workflow skills (https://github.com/nchandar/skills)
if [ ! -d "$HOME/skills" ]; then
  echo "Installing workflow skills..."
  git clone https://github.com/nchandar/skills "$HOME/skills"
  make -C "$HOME/skills" install-claude
else
  echo "Skipping existing ~/skills"
fi

# 3d) Claude Code CLI
if ! command -v claude >/dev/null 2>&1; then
  echo "Installing Claude Code CLI..."
  npm install -g @anthropic-ai/claude-code
else
  echo "Skipping existing Claude Code CLI"
fi

# 3e) Ghostty config sanity check (needs absolute XDG_CONFIG_HOME)
if [ -f "$DOTFILES_DIR/config/ghostty/config" ]; then
  ghostty_xdg="$(sed -nE 's/^env = XDG_CONFIG_HOME=(.*)$/\1/p' "$DOTFILES_DIR/config/ghostty/config" | head -n1)"
  if [ -n "$ghostty_xdg" ] && [ "$ghostty_xdg" != "$HOME/.config" ]; then
    echo "Warning: Ghostty XDG_CONFIG_HOME is '$ghostty_xdg' but should be '$HOME/.config'."
    echo "Update $DOTFILES_DIR/config/ghostty/config for this machine."
  fi
fi

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
  if [ -f "$CONFIG_DIR/tmux/tmux.conf" ] && \
     grep -q "run '~/.tmux/plugins/tpm/tpm'" "$CONFIG_DIR/tmux/tmux.conf"; then
    echo "Warning: tmux.conf still points TPM at ~/.tmux/plugins; update to ~/.config/tmux/plugins."
  fi

  if [ -x "$TPM_DIR/bin/install_plugins" ]; then
    if command -v tmux >/dev/null 2>&1; then
      tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$TMUX_PLUGIN_DIR" >/dev/null 2>&1 || true
    fi
    TMUX_PLUGIN_MANAGER_PATH="$TMUX_PLUGIN_DIR" "$TPM_DIR/bin/install_plugins"
  fi
fi

echo "Done."
