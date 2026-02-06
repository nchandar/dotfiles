-- Lazy.nvim bootstrap (portable: uses stdpath data)
local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.mason"),
  require("plugins.none-ls"),
  require("plugins.cmp"),
  require("plugins.friendly-snippets"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.telescope-ui-select"),
  require("plugins.lualine"),
  require("plugins.devicons"),
  require("plugins.neo-tree"),
  require("plugins.gitsigns"),
  require("plugins.which-key"),
  require("plugins.catppuccin"),
  require("plugins.alpha"),
  require("plugins.tmux-navigator"),
})
