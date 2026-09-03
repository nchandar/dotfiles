# Yazi

- Install path: managed by `Brewfile` and installed by `make bootstrap` / `make brew`
- Config path: `config/yazi/`
- Symlink target: `~/.config/yazi`
- Main config file: `config/yazi/yazi.toml`
- Recommended launch command in macOS zsh: `y`

The zsh `y` wrapper calls `yazi --cwd-file ...` so quitting with `q` updates the shell's current working directory. Upstream Yazi documents both `brew install yazi` and the `y` shell-wrapper pattern.
