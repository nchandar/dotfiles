# Neovim

- Config path: `config/nvim/`
- Base: LazyVim (`LazyVim/LazyVim`) with local overrides in `lua/config/` and `lua/plugins/`
- Full details: `config/nvim/README.md`

## Local customizations
- Keymaps kept at pure LazyVim defaults (no custom remaps)
- Diffview plugin retained for Git diff/file-history commands
- Optional Catppuccin colorscheme installed (LazyVim default theme remains default)
- Snacks picker input uses a local `fixbuf = false` stability override (Neovim `0.11.x`)

## Update tooling
`make update` runs `make upgrade`, then:
- `Lazy sync`
- `TSUpdate`

## Diffview quick commands
- `:DiffviewOpen`
- `:DiffviewOpen HEAD~1`
- `:DiffviewFileHistory %`
- `:DiffviewClose`
