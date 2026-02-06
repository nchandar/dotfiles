# Neovim

Portable Neovim setup for this dotfiles repo. Config lives in `config/nvim/` and is symlinked to `~/.config/nvim` by `bootstrap.sh`.

## What’s included
- Modular Lua config under `lua/` (options, keymaps, LSP, diagnostics).
- Plugin manager: `lazy.nvim` (bootstraps to Neovim data dir).
- Plugins: Treesitter, Telescope (+ UI select), Neo-tree, Lualine, Gitsigns, Which-key, Catppuccin, Alpha dashboard.
- Autocomplete + snippets: `nvim-cmp`, `LuaSnip`, `friendly-snippets`.
- LSP: Neovim built-in `vim.lsp.config` with Mason for server installs.
- Diagnostics: inline virtual text (updates in insert mode).
- none-ls: formatters/linters (Lua, JS/TS, Shell, Python, Go, Rust).
- LSP servers installed via Brewfile for HTML, CSS, JS/TS, Java, and Lua.
- `tree-sitter-cli` installed via Brewfile for `nvim-treesitter` healthchecks and parser updates.

## Install
1. Ensure `neovim` is installed via `brew bundle` or `make bootstrap`.
2. Link configs: `make link` or `make bootstrap`.
3. Open Neovim to let `lazy.nvim` install plugins.
4. Run `:Lazy sync` if needed.

## Files
- `config/nvim/init.lua`
- `config/nvim/CHEATSHEET.md`
- `config/nvim/lua/plugins.lua` (plugin list)
- `config/nvim/lua/plugins/` (plugin modules)
- `config/nvim/lua/config/` (options, keymaps, LSP, diagnostics, alpha, cmp, none-ls)

## Notes
- All paths use `stdpath()` for portability.
- Add LSPs by extending `config/nvim/lua/config/lsp.lua`.
