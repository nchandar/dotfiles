# Ghostty

- Config path: `config/ghostty/`
- Main file: `config/ghostty/config`
- Theme files: `config/ghostty/themes/`
- Default font: `JetBrainsMono Nerd Font` at size `14`
- Update command: `make upgrade` (or `brew upgrade --cask --greedy-auto-updates ghostty`)

Note: this setup uses wrapper scripts to ensure `XDG_CONFIG_HOME` behavior is portable.
On Omarchy/Linux, launcher scripts call `nu` and `tmux` from `PATH`.
