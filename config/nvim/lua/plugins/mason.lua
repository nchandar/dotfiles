return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "html", "cssls", "jsonls", "ts_ls", "jdtls" },
    })
  end,
}
