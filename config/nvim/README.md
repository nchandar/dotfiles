# Neovim (LazyVim)

This repo now uses a **LazyVim-based** setup in `config/nvim/`.

## What’s included
- Base distribution: `LazyVim/LazyVim`.
- Plugin manager: `lazy.nvim`.
- Keymaps: LazyVim defaults plus one custom Git mapping: `<leader>gg` -> `:LazyGit`.
- Default finder: Telescope via LazyVim extra `lazyvim.plugins.extras.editor.telescope`.
- LSP servers enabled via `nvim-lspconfig`: `lua_ls`, `html`, `cssls`, `jsonls`, `ts_ls`, `jdtls`.
- Formatting/linting via LazyVim-native stack:
  - `conform.nvim`: `stylua`, `prettier`, `shfmt`, `black`, `goimports` + `gofmt`, `rustfmt`
  - `nvim-lint`: `eslint_d`, `shellcheck`, `ruff`
- Git workflows: `diffview.nvim` commands for diffs/history and `lazygit.nvim` for terminal Git UI.
- Theme setup: LazyVim default colorscheme remains default; `catppuccin` is installed as an optional alternative.

## Install
1. Ensure dependencies are installed (`brew bundle` or `make bootstrap`).
2. Link configs (`make link` or `make bootstrap`).
3. `make bootstrap` now runs a headless Neovim plugin sync automatically.
4. Open Neovim and run `:Lazy sync` only if you need to resync manually.

`lazygit` is installed through the repo `Brewfile` and is required for `:LazyGit`.

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

## LazyGit commands
- `:LazyGit`
- `:LazyGitCurrentFile`
- `:LazyGitFilter`
- `:LazyGitFilterCurrentFile`

## Git keymaps
- `<leader>gg`: open `LazyGit`

## Telescope commands
- `:Telescope find_files`
- `:Telescope live_grep`
- `:Telescope buffers`
- `:Telescope keymaps`

## Files
- `config/nvim/init.lua`
- `config/nvim/lazyvim.json`
- `config/nvim/lua/config/lazy.lua`
- `config/nvim/lua/config/options.lua`
- `config/nvim/lua/config/keymaps.lua`
- `config/nvim/lua/plugins/lsp.lua`
- `config/nvim/lua/plugins/formatting.lua`
- `config/nvim/lua/plugins/diffview.lua`
- `config/nvim/lua/plugins/lazygit.lua`
- `config/nvim/lua/plugins/tmux-navigator.lua`
- `config/nvim/lua/plugins/catppuccin.lua`

## Notes
- Conflict policy is to keep LazyVim defaults where overlaps exist, with a single repo-local LazyGit launcher on `<leader>gg`.
- Leader-based motions/actions follow LazyVim defaults.
- Finder mappings like `<leader><space>`, `<leader>/`, and `<leader>,` now open Telescope pickers.
