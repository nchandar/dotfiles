# dotfiles

Portable macOS terminal + desktop setup.

## What's in here
- `config/nushell/` Nushell config (`config.nu`, `env.nu`, `carapace.nu`)
- `config/tmux/` tmux config (`tmux.conf`, `tmux.reset.conf`)
- `config/ghostty/` Ghostty config (including themes)
- `config/hammerspoon/` Hammerspoon config (`init.lua`)
- `config/starship.toml` Starship prompt config
- `Brewfile` Homebrew packages used for this setup

## Layout
- `config/` versioned configs that are symlinked into `~/.config`
- `local/` machine-specific overrides or notes (ignored by git)

## Bootstrap
```sh
bash ~/dotfiles/bootstrap.sh
```
Or with Make:
```sh
cd ~/dotfiles
make bootstrap
```

## Setup on a new Mac (recommended)
```sh
git clone git@github.com:nchandar/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

## Setup on a new Mac (manual)
1) Install Homebrew (if needed)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2) Install packages
```sh
brew bundle --file ~/dotfiles/Brewfile
```

3) Symlink configs into `~/.config`
```sh
mkdir -p ~/.config
ln -s ~/dotfiles/config/nushell ~/.config/nushell
ln -s ~/dotfiles/config/tmux ~/.config/tmux
ln -s ~/dotfiles/config/ghostty ~/.config/ghostty
ln -s ~/dotfiles/config/hammerspoon ~/.config/hammerspoon
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
```

## Make targets
- `make bootstrap` run full bootstrap (brew + links)
- `make brew` run only Homebrew bundle
- `make link` create symlinks only
- `make status` show current symlinks

## Options and settings
- **Symlinks vs copy**: This setup uses symlinks so the repo is the single source of truth. If you prefer copies, do so manually but keep them in sync.
- **tmux plugins**: Managed by TPM. `config/tmux/plugins/` is ignored by git and will be populated on first tmux run.
- **Nushell history**: `config/nushell/history*` is ignored by git and will be regenerated.
- **Local overrides**: Put per-machine notes or overrides in `local/` (ignored).

## Git ignored items
- `local/`
- tmux plugins and other generated/runtime files
- Nushell history
