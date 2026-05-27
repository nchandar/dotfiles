export PATH="$HOME/.opencode/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim

# Oh My Posh
if command -v oh-my-posh &>/dev/null && [[ -f "$HOME/.config/oh-my-posh.omp.toml" ]]; then
  eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh.omp.toml")"
fi

# Carapace completions
if command -v carapace &>/dev/null; then
  autoload -Uz compinit && compinit
  source <(carapace _carapace zsh)
fi

# Yazi: change to yazi's last working directory on exit
y() {
  local tmp
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file "$tmp"
  local cwd
  cwd="$(cat "$tmp")"
  if [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}
