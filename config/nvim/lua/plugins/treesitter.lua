local shim = require("config.treesitter_shim")

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    shim.ensure_ft_to_lang()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      if #vim.api.nvim_list_uis() > 0 then
        vim.notify(
          "nvim-treesitter not available. Run :Lazy sync to install.",
          vim.log.levels.WARN
        )
      end
      return
    end
    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "yaml", "toml", "markdown", "TypeScript", "JavaScript" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
