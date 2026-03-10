# Bootstrap

## Full setup
```sh
cd ~/dotfiles
make bootstrap
```

## What this does
1. Installs Homebrew packages from `Brewfile`
2. Creates symlinks from `config/` into `~/.config`
3. Installs tmux TPM/plugins

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
