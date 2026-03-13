# Nushell

- Config path: `config/nushell/`
- Main files: `config.nu`, `env.nu`, `carapace.nu`
- Prompt: initializes `oh-my-posh` from `~/.config/oh-my-posh.omp.toml` when installed
- `y` command: launches `yazi` with `--cwd-file` so quitting with `q` updates the current shell directory

History files are runtime-generated and ignored by git.
