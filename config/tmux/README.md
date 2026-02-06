# tmux config

This directory contains the tmux config used by this dotfiles repo.

## Files
- `tmux.conf` main config (symlinked to `~/.config/tmux/tmux.conf`)
- `tmux.reset.conf` optional reset file (if you use it)

## Terminal + colors
- `default-terminal`: `tmux-256color`
- `terminal-overrides`: `*:Tc` and `xterm-256color:RGB`

## Prefix
- Prefix is `C-g`
- Alternate prefix is `C-]` (use if `C-g` is intercepted by the terminal)
- `C-b` is unbound
- `C-g` sends prefix
- `C-]` sends prefix

## Key mappings (daily)
| Area | Key | Action |
| --- | --- | --- |
| Prefix | `C-g` | Prefix key |
| Prefix | `C-]` | Alternate prefix |
| Splits | `=` or `]` | Split horizontally |
| Splits | `-` or `\` | Split vertically |
| Panes | `h` | Resize pane left by 5 |
| Panes | `j` | Resize pane down by 5 |
| Panes | `k` | Resize pane up by 5 |
| Panes | `l` | Resize pane right by 5 |
| Panes | `m` | Toggle zoom for current pane |
| Session | `r` | Reload config |
| Copy (vi) | `v` | Begin selection |
| Copy (vi) | `y` | Copy selection |

## Key mappings (advanced)
| Area | Key | Action |
| --- | --- | --- |
| Prefix | `C-g` | Send prefix (for nested tmux) |
| Prefix | `C-]` | Send prefix (for nested tmux) |
| Session | `M-c` | Attach session in current pane path |
| Mouse | drag | Mouse drag does not exit copy mode |

## Cheatsheet (quick)
```
Prefix: C-g (alt: C-])
Split:  = or ] (horiz)  - or \ (vert)
Resize: h/j/k/l (5 cells)
Zoom:   m
Reload: r
Attach in cwd: M-c
Copy (vi): v start, y copy
Mouse: on
```

## Plugins (TPM)
- tmux-plugins/tpm
- tmux-plugins/tmux-sensible
- tmux-plugins/tmux-yank
- tmux-plugins/tmux-resurrect
- tmux-plugins/tmux-continuum
- fcsonline/tmux-thumbs
- sainnhe/tmux-fzf
- wfxr/tmux-fzf-url
- omerxx/catppuccin-tmux
- omerxx/tmux-sessionx
- omerxx/tmux-floax

## Notes
- This config is symlinked into `~/.config/tmux` by `make link` or `make bootstrap`.
- If you also use a `~/.tmux.conf` shim, it should source `~/.config/tmux/tmux.conf`.
