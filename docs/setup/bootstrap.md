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
bash bootstrap-omarchy.sh
make bootstrap-omarchy
```

## Omarchy dependency install (quick)
Install these packages with your normal package manager before running bootstrap:

`nushell`, `neovim`, `tmux`, `ghostty`, `oh-my-posh`, `lazygit`, `carapace`, `node`, `go`, `rust`, `yazi`

Example:

```sh
sudo pacman -S nushell neovim tmux ghostty oh-my-posh lazygit carapace nodejs go rust yazi
```

If your distro uses different package names, swap to the matching ones for your repository.

## What this does
1. macOS: installs Homebrew packages from `Brewfile`
2. Creates symlinks from `config/` into `~/.config`
3. Installs tmux TPM/plugins
4. Runs headless Neovim plugin sync (`Lazy sync` + `TSUpdate`)

For Omarchy/Linux flow, dependency install is done with the distro/Omarchy package tools, then:
1. Creates symlinks for shell, tmux, Ghostty, and nvim configs
2. Installs tmux TPM/plugins
3. Runs headless Neovim plugin sync (`Lazy sync` + `TSUpdate`)

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

## Omarchy/ Linux status check (quick)

```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --link-only
```
