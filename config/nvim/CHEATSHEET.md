# Neovim Cheatsheet (LazyVim)

Most-used actions for this repo’s LazyVim setup.

## Modes
- Normal: `Esc`
- Insert: `i`
- Visual: `v`
- Command line: `:`

## Core file actions
- Save: `:w`
- Quit all: `<leader>qq`
- Save and quit: `:wq`
- Force quit: `:q!`

## Finder / navigation (LazyVim defaults)
- Find files (root): `<leader><space>`
- Live grep (root): `<leader>/`
- Explorer: `<leader>e`
- Buffer switcher: `<leader>,`

## Diagnostics and LSP (LazyVim defaults)
- Prev/next diagnostic: `[d` / `]d`
- Code action: `<leader>ca`
- Rename symbol: `<leader>cr`
- Go to definition: `gd`
- References: `gr`
- Hover docs: `K`

## Diffview (kept)
- Open diff: `:DiffviewOpen`
- Open commit diff: `:DiffviewOpen HEAD~1`
- Current file history: `:DiffviewFileHistory %`
- Close diff: `:DiffviewClose`

## Useful commands
- Open Lazy UI: `:Lazy`
- Open Mason UI: `:Mason`
- Check health: `:checkhealth`
- Inspect active mappings: `:Telescope keymaps`

## Notes
- Snacks picker runs with a local input-window stability override (`fixbuf = false`) for Neovim `0.11.x`.

## Leader key
- Leader is `Space`.
