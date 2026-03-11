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

## Finder / navigation (LazyVim defaults, Telescope-backed)
- Find files (root): `<leader><space>` or `:Telescope find_files`
- Live grep (root): `<leader>/` or `:Telescope live_grep`
- Explorer: `<leader>e`
- Buffer switcher: `<leader>,` or `:Telescope buffers`

## Diagnostics and LSP (LazyVim defaults)
- Prev/next diagnostic: `[d` / `]d`
- Code action: `<leader>ca`
- Rename symbol: `<leader>cr`
- Go to definition: `gd`
- References: `gr`
- Hover docs: `K`

## Git
- Open LazyGit: `<leader>gg` or `:LazyGit`
- Open LazyGit for current file: `:LazyGitCurrentFile`
- Open LazyGit with repo filter: `:LazyGitFilter`
- Open LazyGit filtered to current file: `:LazyGitFilterCurrentFile`

## Diffview
- Open diff: `:DiffviewOpen`
- Open commit diff: `:DiffviewOpen HEAD~1`
- Current file history: `:DiffviewFileHistory %`
- Close diff: `:DiffviewClose`

## Useful commands
- Open Lazy UI: `:Lazy`
- Open Mason UI: `:Mason`
- Check health: `:checkhealth`
- Inspect active mappings: `:Telescope keymaps`

## Leader key
- Leader is `Space`.
