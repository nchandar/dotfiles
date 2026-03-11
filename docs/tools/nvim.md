# Neovim

- Config path: `config/nvim/`
- Base: LazyVim (`LazyVim/LazyVim`) with local overrides in `lua/config/` and `lua/plugins/`
- Full details: `config/nvim/README.md`

## Local customizations
- Keymaps are mostly LazyVim defaults, with one repo-local Git launcher on `<leader>gg`
- Telescope finder enabled via LazyVim extra `lazyvim.plugins.extras.editor.telescope`
- Diffview plugin retained for Git diff/file-history commands
- LazyGit plugin added for terminal Git UI commands inside Neovim
- Optional Catppuccin colorscheme installed (LazyVim default theme remains default)

## Finder quick commands
- `:Telescope find_files`
- `:Telescope live_grep`
- `:Telescope buffers`
- `:Telescope keymaps`

## Update tooling
`make update` runs `make upgrade`, then:
- `Lazy sync`
- `TSUpdate`

## Diffview quick commands
- `:DiffviewOpen`
- `:DiffviewOpen HEAD~1`
- `:DiffviewFileHistory %`
- `:DiffviewClose`

## LazyGit quick commands
- `<leader>gg`
- `:LazyGit`
- `:LazyGitCurrentFile`
- `:LazyGitFilter`
- `:LazyGitFilterCurrentFile`
