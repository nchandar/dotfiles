local shim = require("config.treesitter_shim")

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    shim.ensure_ft_to_lang()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    -- Guard against plugins resetting vim.treesitter after telescope loads.
    local ok_utils, previewers_utils = pcall(require, "telescope.previewers.utils")
    if ok_utils and previewers_utils and previewers_utils.ts_highlighter then
      local original = previewers_utils.ts_highlighter
      previewers_utils.ts_highlighter = function(bufnr, lang)
        shim.ensure_ft_to_lang()
        if not (vim.treesitter and vim.treesitter.ft_to_lang) then
          vim.treesitter = vim.treesitter or {}
          vim.treesitter.ft_to_lang = function(ft)
            return ft
          end
        end
        return original(bufnr, lang)
      end
    end
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<Esc>"] = actions.close },
          n = { ["<Esc>"] = actions.close },
        },
      },
    })
  end,
}
