# Keyboard Shortcuts ⌨️

This is the single quick-reference page across all tools in this dotfiles repo.

## <u>Key names</u> 🧭
| Name in docs | macOS key |
| --- | --- |
| `alt` | `Option (⌥)` |
| `cmd` | `Command (⌘)` |
| `ctrl` | `Control (^)` |
| `shift` | `Shift (⇧)` |
| `leader` (Neovim) | `Space` |

## <u>AeroSpace</u> 🪟
| Shortcut | Action |
| --- | --- |
| `alt-h/j/k/l` | Focus window left/down/up/right |
| `alt-shift-h/j/k/l` | Move focused window left/down/up/right |
| `alt-/` | Cycle tiles layout orientation |
| `alt-,` | Cycle accordion layout orientation |
| `alt--` / `alt-=` | Resize smaller/larger |
| `alt-b` | Balance sizes of windows |
| `alt-1..9` | Switch workspace |
| `alt-shift-1..9` | Move focused window to workspace |
| `alt-tab` | Previous workspace |
| `alt-shift-tab` | Move workspace to next monitor |
| `alt-shift-;` | Enter service mode |
| `service: esc` | Reload config and return to main mode |
| `service: r` | Flatten workspace tree |
| `service: f` | Toggle floating/tiling |
| `service: backspace` | Close all windows except focused |

## <u>Hammerspoon</u> 🔨
| Shortcut | Action |
| --- | --- |
| `ctrl+option+cmd+Left` | Left half |
| `ctrl+option+cmd+Right` | Right half |
| `ctrl+option+cmd+Up` | Top half |
| `ctrl+option+cmd+Down` | Bottom half |
| `ctrl+option+cmd+m` | Maximize window |
| `cmd+option+Left` | Left third (wide screen layout) |
| `cmd+option+Down` | Middle third (wide screen layout) |
| `cmd+option+Right` | Right third (wide screen layout) |
| `ctrl+option+cmd+l` | Start screensaver |
| `ctrl+option+cmd+z` | Open webview demo |
| `ctrl+option+cmd+c` | Toggle AutoClick |

## <u>tmux</u> 🧱
| Shortcut | Action |
| --- | --- |
| `Ctrl-g` | Prefix key |
| `Ctrl-]` | Alternate prefix |
| `prefix` + `=` or `]` | Horizontal split |
| `prefix` + `-` or `\` | Vertical split |
| `prefix` + `h/j/k/l` | Resize pane |
| `prefix` + `m` | Toggle zoom |
| `prefix` + `r` | Reload config |
| `prefix` + `v` then `y` | Copy mode select and yank |

## <u>Neovim (LazyVim + local Git/debug shortcuts)</u> ✍️
| Shortcut | Action |
| --- | --- |
| `:w` | Save |
| `<leader><space>` | Telescope find files (root) |
| `<leader>/` | Telescope live grep (root) |
| `<leader>,` | Telescope buffers list |
| `<leader>e` | File explorer |
| `<leader>gg` | Open LazyGit |
| `<F5>` | Debug continue/start |
| `<F10>` | Debug step over |
| `<F11>` | Debug step into |
| `<F12>` | Debug step out |
| `<leader>b` | Toggle debug breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<leader>du` | Toggle DAP UI |
| `<leader>qq` | Quit all |
| `[d` / `]d` | Prev/next diagnostic |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<leader>cr` | Rename symbol |
| `<leader>ca` | Code action |

## <u>Neovim Java debug/test</u> ☕
| Shortcut | Action |
| --- | --- |
| `<leader>tt` | Run current Java test class through the debugger |
| `<leader>tr` | Run nearest Java test through the debugger |
| `<leader>tT` | Pick a Java test to run |

## <u>Diffview (Neovim Git commands)</u> 🔍
| Command | Action |
| --- | --- |
| `:DiffviewOpen` | Open Git diff view for staged/unstaged changes |
| `:DiffviewOpen HEAD~1` | Open diff for a commit/ref |
| `:DiffviewFileHistory %` | Show history for current file |
| `:DiffviewClose` | Close Diffview tab |

## <u>LazyGit (Neovim Git UI)</u> 🌿
| Shortcut / Command | Action |
| --- | --- |
| `<leader>gg` or `:LazyGit` | Open LazyGit for the current repo |
| `:LazyGitCurrentFile` | Open LazyGit focused on the current file |
| `:LazyGitFilter` | Open LazyGit with a repository filter |
| `:LazyGitFilterCurrentFile` | Open LazyGit filtered to the current file |

## <u>Markdown authoring (Neovim)</u> 📝
| Command | Action |
| --- | --- |
| `:Markview Toggle` | Toggle in-buffer Markdown rendering |
| `:Markview splitToggle` | Toggle Markview split preview |
| `:Markview HybridToggle` | Toggle Markview hybrid edit/preview mode |
| `:MarkdownPreview` | Start browser Markdown preview |
| `:MarkdownPreviewToggle` | Toggle browser Markdown preview |
| `:MarkdownPreviewStop` | Stop browser Markdown preview |
| `:checkhealth markview` | Check Markview parser and setup health |

## <u>Other tools in this repo</u> 🧰
| Tool | Shortcut status |
| --- | --- |
| Ghostty | No custom keyboard shortcuts defined in `config/ghostty/config` |
| Yazi | Start with `y` from zsh to preserve the shell's current directory; no key overrides from defaults |
| Oh My Posh | Prompt config only, no keyboard shortcuts |
| gitmux | tmux status integration, no standalone keyboard shortcuts |

## <u>Full detail pages</u> 📚
| Page | Link |
| --- | --- |
| AeroSpace details | [AeroSpace details](keybindings/aerospace.md) |
| Hammerspoon details | [Hammerspoon details](keybindings/hammerspoon.md) |
| tmux details | [tmux details](keybindings/tmux.md) |
| Neovim details | [Neovim details](tools/nvim.md) |
| Keybindings overview | [Overview](keybindings/index.md) |
