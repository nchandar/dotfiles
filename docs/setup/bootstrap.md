# Bootstrap

## Full setup

### macOS
```sh
cd ~/dotfiles
make bootstrap
```

### Omarchy / Linux
```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --install-deps
make bootstrap-omarchy
```

`bootstrap-omarchy.sh` and `make bootstrap-omarchy` are Linux-only and will fail fast on macOS.

On macOS, `make bootstrap` installs the repo's Homebrew bundle from `Brewfile`, including `ghostty`, `visual-studio-code`, `claude-code`, `codex`, and `opencode`.

## Omarchy dependency install (quick)
Install these packages with your normal package manager before running bootstrap:

`zsh`, `neovim`, `tmux`, `ghostty`, `oh-my-posh`, `lazygit`, `carapace`, `code`, `node`, `go`, `rust`, `yazi`, `opencode`, `openai-codex`

Example:

```sh
sudo pacman -S zsh neovim tmux ghostty oh-my-posh lazygit carapace code nodejs go rust yazi opencode openai-codex
```

If your repos do not have `oh-my-posh` or `carapace`, use `oh-my-posh-bin` and/or `carapace-bin` from your AUR/helper flow.
If your distro uses different package names, swap to the matching ones for your repository.
Claude Code currently needs its own installer outside this pacman flow.

## What this does
1. macOS: installs Homebrew packages from `Brewfile` (including `ghostty`, `visual-studio-code`, `claude-code`, `codex`, and `opencode`)
2. Creates symlinks from `config/` into `~/.config`
3. Installs tmux TPM/plugins
4. Runs headless Neovim plugin sync (`Lazy sync` + `TSUpdate`)

Bootstrap also links shared AI config files into their native homes:

- `config/opencode/opencode.jsonc` -> `~/.config/opencode/opencode.jsonc`
- `config/codex/config.toml` -> copied into `~/.codex/config.toml` if missing
- `config/claude/settings.json` -> `~/.claude/settings.json`

This repo also commits Claude Code project files directly:

- `.mcp.json` for Claude Code's project-scoped MCP servers

Manual plugin activation still applies where the harness requires it:

- OpenCode: no marketplace step; restart after `opencode.jsonc` changes.
- Claude Code: install Superpowers once with `/plugin install superpowers@claude-plugins-official`.
- Codex: install Superpowers once from the `/plugins` UI.

For Omarchy/Linux flow, dependency install is done with the distro/Omarchy package tools, then:
1. Creates symlinks for shell, tmux, Ghostty, and nvim configs
2. Installs tmux TPM/plugins
3. Runs headless Neovim plugin sync (`Lazy sync` + `TSUpdate`)

With `--install-deps` (or `make bootstrap-omarchy`) on pacman-based systems, bootstrap also installs required packages first.

## Update existing machine
```sh
cd ~/dotfiles
make upgrade
```

For a full refresh including tmux and Neovim plugins:
```sh
cd ~/dotfiles
make update
```

`make upgrade` also refreshes the Homebrew-installed GUI and CLI apps from `Brewfile`, including Ghostty, VS Code, Claude Code, Codex, and OpenCode on macOS.

## Omarchy/ Linux status check (quick)

```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --link-only
```
