# Neovim Cheatsheet

Most common actions, default Vim keys, plus this config’s leader bindings.

## Modes
- Normal: press `Esc`.
- Insert: press `i`.
- Visual: press `v`.
- Visual line: press `V`.
- Command: press `:` in Normal.

## File and Buffer
- Open file: `:e path/to/file`
- Save: `:w` or `<leader>w`
- Save and quit: `:wq`
- Quit: `:q` or `<leader>q`
- Force quit: `:q!`
- List buffers: `:ls`
- Next buffer: `:bnext`
- Prev buffer: `:bprev`
- Switch buffer: `:b 3`
- Close buffer: `:bd`

## Navigation
- Start of line: `0`
- First non-blank: `^`
- End of line: `$`
- Top of file: `gg`
- Bottom of file: `G`
- Go to line: `:123`
- Half page down: `Ctrl-d`
- Half page up: `Ctrl-u`
- Next word: `w`
- Prev word: `b`
- End of word: `e`

## Editing
- Insert before cursor: `i`
- Insert after cursor: `a`
- Insert at line start: `I`
- Insert at line end: `A`
- New line below: `o`
- New line above: `O`
- Undo: `u`
- Redo: `Ctrl-r`
- Delete char: `x`
- Delete word: `dw`
- Delete line: `dd`
- Change word: `cw`
- Change line: `cc`
- Yank line: `yy`
- Paste after: `p`
- Paste before: `P`
- Repeat last change: `.`

## Visual Mode
- Select word: `viw`
- Select line: `V`
- Indent right: `>`
- Indent left: `<`
- Move selection up: `K`
- Move selection down: `J`

## Search and Replace
- Search: `/pattern`
- Next match: `n`
- Prev match: `N`
- Search current word: `*`
- Replace in line: `:s/old/new/g`
- Replace in file: `:%s/old/new/g`
- Replace with confirm: `:%s/old/new/gc`

## Windows and Splits
- Vertical split: `:vsplit`
- Horizontal split: `:split`
- Move between splits: `Ctrl-w` then `h/j/k/l`
- Close split: `:close`
- Equalize sizes: `Ctrl-w =`

## Tabs
- New tab: `:tabnew`
- Next tab: `gt`
- Prev tab: `gT`
- Close tab: `:tabclose`

## Telescope (this config)
- Find files: `<leader>ff`
- Live grep: `<leader>fg`
- Buffers: `<leader>fb`
- Help tags: `<leader>fh`

## Ctrl shortcuts (this config)
- Save: `Ctrl-s`
- Quit: `Ctrl-q`
- Find in file: `Ctrl-f`
- Replace in file: `Ctrl-r`
- Find in project: `Ctrl-Shift-f`
- Find files: `Ctrl-p`
- Buffers: `Ctrl-b`
- File explorer: `Ctrl-e`
- Copy selection: `Ctrl-c`
- Cut selection: `Ctrl-x`
- Paste: `Ctrl-v`
- Delete line/selection (no yank): `Ctrl-d`

## Diagnostics and LSP (this config)
- Prev diagnostic: `[d`
- Next diagnostic: `]d`
- Diagnostics float: `<leader>dd`
- Go to definition: `gd`
- References: `gr`
- Hover docs: `K`
- Rename: `<leader>rn`
- Code action: `<leader>ca`

## Misc
- File explorer: `<leader>e`
- Toggle search highlight: `:set hlsearch!`

## Leader key
- Leader is `Space`.
