#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"
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

link_file() {
  src="$1"
  dest="$2"
  parent_dir="$(dirname "$dest")"

  mkdir -p "$parent_dir"

  if [ -L "$dest" ]; then
    current_target="$(readlink "$dest")"
    if [ "$current_target" = "$src" ]; then
      echo "Skipping existing $dest"
      return
    fi
    echo "Skipping existing $dest"
    return
  fi

  if [ -e "$dest" ]; then
    echo "Skipping existing $dest"
    return
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

copy_file_if_missing() {
  src="$1"
  dest="$2"
  parent_dir="$(dirname "$dest")"

  mkdir -p "$parent_dir"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing $dest"
    return
  fi

  cp "$src" "$dest"
  echo "Copied $dest from $src"
}

link_file "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
link ghostty
link hammerspoon
link aerospace
link nvim
link yazi
link oh-my-posh.omp.toml
link_file "$DOTFILES_DIR/config/herdr/config.toml" "$CONFIG_DIR/herdr/config.toml"
link_file "$DOTFILES_DIR/config/opencode/opencode.jsonc" "$CONFIG_DIR/opencode/opencode.jsonc"
copy_file_if_missing "$DOTFILES_DIR/config/codex/config.toml" "$HOME/.codex/config.toml"

# 3a) One global instruction file for every agent. Claude's CLAUDE.md in config/claude is a repo symlink to it.
link_file "$DOTFILES_DIR/config/agents/AGENTS.md" "$HOME/.agents/AGENTS.md"
link_file "$DOTFILES_DIR/config/agents/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_file "$DOTFILES_DIR/config/agents/AGENTS.md" "$CONFIG_DIR/opencode/AGENTS.md"

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

# 3c-2) Agent harness: dev-* skills for Claude, Codex and OpenCode, plus bin/ tools
"$DOTFILES_DIR/agents/harness/install.sh"

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

# 4) Install Herdr plugins after Homebrew and config linking are complete.
if [ "$LINK_ONLY" = false ] && [ -x "$DOTFILES_DIR/scripts/install-herdr-plugins.sh" ]; then
  if ! "$DOTFILES_DIR/scripts/install-herdr-plugins.sh"; then
    echo "Herdr plugin install failed; run 'make herdr' after resolving the prerequisite."
  fi
fi

echo "Done."
