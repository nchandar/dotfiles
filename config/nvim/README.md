# Neovim (LazyVim)

This repo now uses a **LazyVim-based** setup in `config/nvim/`.

## What’s included
- Base distribution: `LazyVim/LazyVim`.
- Plugin manager: `lazy.nvim`.
- Keymaps: pure LazyVim defaults (no custom remaps).
- LSP servers enabled via `nvim-lspconfig`: `lua_ls`, `html`, `cssls`, `jsonls`, `ts_ls`, `jdtls`.
- Formatting/linting via LazyVim-native stack:
  - `conform.nvim`: `stylua`, `prettier`, `shfmt`, `black`, `goimports` + `gofmt`, `rustfmt`
  - `nvim-lint`: `eslint_d`, `shellcheck`, `ruff`
- Git diff workflow: `diffview.nvim` commands (in addition to LazyVim git defaults).
- Theme setup: LazyVim default colorscheme remains default; `catppuccin` is installed as an optional alternative.
- Snacks picker: includes a local `fixbuf = false` input-window override for stability on Neovim `0.11.x`.

## Install
1. Ensure dependencies are installed (`brew bundle` or `make bootstrap`).
2. Link configs (`make link` or `make bootstrap`).
3. Open Neovim once to install/sync plugins.
4. Run `:Lazy sync` if needed.

## Update (headless)
```sh
nvim --headless "+Lazy sync" +qa
nvim --headless "+TSUpdate" +qa
```
These are also run by `make update` from repo root.

## Diffview commands
- `:DiffviewOpen`
- `:DiffviewOpen HEAD~1`
- `:DiffviewFileHistory %`
- `:DiffviewClose`

## Files
- `config/nvim/init.lua`
- `config/nvim/lua/config/lazy.lua`
- `config/nvim/lua/config/options.lua`
- `config/nvim/lua/config/keymaps.lua`
- `config/nvim/lua/plugins/lsp.lua`
- `config/nvim/lua/plugins/formatting.lua`
- `config/nvim/lua/plugins/diffview.lua`
- `config/nvim/lua/plugins/tmux-navigator.lua`
- `config/nvim/lua/plugins/catppuccin.lua`
- `config/nvim/lua/plugins/snacks.lua`

## Notes
- Conflict policy is to keep LazyVim defaults where overlaps exist.
- Leader-based motions/actions follow LazyVim defaults.
