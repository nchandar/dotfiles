# dotfiles

Portable macOS terminal + desktop setup.

## What's in here
- `config/nushell/` Nushell config (`config.nu`, `env.nu`, `carapace.nu`)
- `config/tmux/` tmux config (`tmux.conf`, `tmux.reset.conf`, `README.md`)
- `config/ghostty/` Ghostty config (including themes)
- `config/hammerspoon/` Hammerspoon config (`init.lua`)
- `config/aerospace/` AeroSpace config (`aerospace.toml`, `README.md`)
- `config/nvim/` Neovim config (LazyVim base + local overrides, Diffview + LazyGit git workflows)
- `config/starship.toml` Starship prompt config
- `Brewfile` Homebrew packages used for this setup
- `TMUX.md` tmux features + key mappings (see `TMUX.md#key-mappings-daily`)

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

## New machine checklist (quick)
```sh
git clone git@github.com:nchandar/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
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
ln -s ~/dotfiles/config/aerospace ~/.config/aerospace
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml
```

4) Install tmux plugins (TPM)
```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
TMUX_PLUGIN_MANAGER_PATH=~/.config/tmux/plugins ~/.config/tmux/plugins/tpm/bin/install_plugins
```

5) Ghostty XDG_CONFIG_HOME (portable)
Ghostty does not expand `$HOME` in `env = ...`, so we set it in a wrapper script.
Edit `config/ghostty/nu.sh` if you want to change the shell or env setup.

6) AeroSpace startup and keybindings
- Startup is enabled via `start-at-login = true` in `config/aerospace/aerospace.toml`.
- Keybinding guide: `config/aerospace/README.md`.

## Make targets
- `make bootstrap` run full bootstrap (brew + links + tmux plugins + Neovim plugin sync)
- `make brew` run only Homebrew bundle
- `make link` create symlinks only
- `make status` show current symlinks
- `make tmux` install TPM + plugins and create `~/.tmux.conf` shim if missing
- `make nvim` run headless `Lazy sync` and `TSUpdate`
- `make upgrade` update Homebrew packages/casks, including auto-updating casks like Ghostty
- `make update` run `make upgrade`, then update tmux plugins and Neovim plugins/tooling

## Docs site
- Source lives in `docs/` with config in `mkdocs.yml`.
- GitHub Pages deploy is automated by `.github/workflows/docs-pages.yml`.
- Local preview:
```sh
python3 -m pip install -r requirements-docs.txt
python3 -m mkdocs serve
```

## Options and settings
- **Symlinks vs copy**: This setup uses symlinks so the repo is the single source of truth. If you prefer copies, do so manually but keep them in sync.
- **tmux plugins**: Managed by TPM. `config/tmux/plugins/` is ignored by git and will be populated on first tmux run or during bootstrap. Bootstrap also creates a `~/.tmux.conf` shim if missing.
- **Nushell history**: `config/nushell/history*` is ignored by git and will be regenerated.
- **Carapace completions**: `carapace` is installed via Brewfile and used for external completions.
- **Neovim**: See `config/nvim/README.md` for LazyVim setup, plugins, keymaps, Git workflows, and tooling details.
- **AeroSpace + Hammerspoon**: Both are enabled. If shortcuts overlap, whichever app captures the shortcut first will act.
- **Local overrides**: Put per-machine notes or overrides in `local/` (ignored).

## Git ignored items
- `local/`
- tmux plugins and other generated/runtime files
- Nushell history
