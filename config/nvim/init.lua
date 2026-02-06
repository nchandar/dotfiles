-- Portable Neovim config for this dotfiles repo
-- Keep all paths relative to XDG config/data

local g = vim.g

require("config.options")
require("plugins")
require("config.keymaps")
require("config.lsp")
require("config.diagnostics")
require("config.autocmds")
