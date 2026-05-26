return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        ts_ls = {},
        -- Java is attached by nvim-jdtls, so keep Mason from trying to install
        -- java-language-server, which fails here because plain `java` has no runtime.
        jdtls = { mason = false },
      },
    },
  },
}
