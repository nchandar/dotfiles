# Symlinks

This repo keeps configs in `config/` and links them into `~/.config`.

## Create links only
```sh
cd ~/dotfiles
make link
```

Omarchy/Linux shortcut:

```sh
cd ~/dotfiles
bash bootstrap-omarchy.sh --link-only
```

## Check links
```sh
cd ~/dotfiles
make status
```

## Managed paths
- `~/.config/nushell`
- `~/.config/tmux`
- `~/.config/ghostty`
- `~/.config/hammerspoon`
- `~/.config/aerospace`
- `~/.config/nvim`
- `~/.config/oh-my-posh.omp.toml`

For Omarchy/Linux, omit these by design:
- `~/.config/hammerspoon`
- `~/.config/aerospace`
