# Troubleshooting

## AeroSpace CLI says server not running
Launch `AeroSpace.app` once and grant macOS accessibility permissions.

## Symlink not updating
If a destination already exists, bootstrap skips it by design. Move or remove the existing file, then rerun:
```sh
make link
```

For Omarchy/Linux-only flows, use:
```sh
bash bootstrap-omarchy.sh --link-only
```

## tmux plugin issues
Reinstall plugins:
```sh
make tmux
```

On Omarchy, if plugins still do not load, verify `tmux` is installed and TPM cloned:
```sh
command -v tmux
ls -la ~/.config/tmux/plugins/tpm
```
Then rerun:
```sh
make bootstrap-omarchy
```

## Omarchy bootstrap: missing executable paths
If bootstrap errors mention `command not found` for `nu`, `tmux`, or `nvim`, install the dependency package, then rerun bootstrap.

```sh
command -v nu
command -v tmux
command -v nvim
command -v ghostty
command -v oh-my-posh
```

Quick reinstall flow:
```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --install-deps
```

If `make bootstrap-omarchy` reports no supported package manager, install dependencies manually for your distro and rerun `bash bootstrap-omarchy.sh`.

If `make bootstrap-omarchy` reports missing `oh-my-posh` or `carapace` packages, install `oh-my-posh-bin` and/or `carapace-bin` via your AUR/helper, then rerun bootstrap.

## Brewfile mismatch
Check and reconcile:
```sh
brew bundle check --file ./Brewfile
brew bundle install --file ./Brewfile
```

## Neovim headless sync failures
If bootstrap fails during `Lazy sync`/`TSUpdate`, rerun sync manually after dependencies are installed:
```sh
nvim --headless "+Lazy sync" +qa
nvim --headless "+TSUpdate" +qa
```

Then verify toolchain support:
```sh
node --version
go version
rustc --version
```

You can also open Neovim normally and run:
```sh
:checkhealth
```
