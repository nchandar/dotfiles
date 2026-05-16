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

On macOS, `make bootstrap` installs the repo's Homebrew bundle from `Brewfile`, including `ghostty`, `visual-studio-code`, and `opencode`.

## Omarchy dependency install (quick)
Install these packages with your normal package manager before running bootstrap:

`nushell`, `neovim`, `tmux`, `ghostty`, `oh-my-posh`, `lazygit`, `carapace`, `code`, `node`, `go`, `rust`, `yazi`, `opencode`

Example:

```sh
sudo pacman -S nushell neovim tmux ghostty oh-my-posh lazygit carapace code nodejs go rust yazi opencode
```

If your repos do not have `oh-my-posh` or `carapace`, use `oh-my-posh-bin` and/or `carapace-bin` from your AUR/helper flow.
If your distro uses different package names, swap to the matching ones for your repository.

## What this does
1. macOS: installs Homebrew packages from `Brewfile` (including `ghostty`, `visual-studio-code`, and `opencode`)
2. Creates symlinks from `config/` into `~/.config`
3. Installs tmux TPM/plugins
4. Runs headless Neovim plugin sync (`Lazy sync` + `TSUpdate`)

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

`make upgrade` also refreshes the Homebrew-installed GUI and CLI apps from `Brewfile`, including Ghostty, VS Code, and OpenCode on macOS.

## Omarchy/ Linux status check (quick)

```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --link-only
```
