return {
  "nvim-telescope/telescope-ui-select.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("ui-select")
      telescope.setup({
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })
    end
  end,
}
