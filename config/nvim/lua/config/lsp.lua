-- Mason (optional)
local ok_mason, mason = pcall(require, "mason")
if ok_mason then
  mason.setup({})
  local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
  if ok_mason_lsp then
    mason_lsp.setup({
      ensure_installed = { "lua_ls", "html", "cssls", "jsonls", "ts_ls", "jdtls" },
    })
  end
end

-- Common on_attach/keymaps are handled in config/keymaps.lua via LspAttach
if vim.lsp and vim.lsp.config then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end
  local function enable_if_available(name, cmd)
    if vim.fn.executable(cmd[1]) == 1 then
      if vim.lsp.enable then
        vim.lsp.enable(name)
      end
    else
      vim.notify(cmd[1] .. " not found in PATH. Install it to enable " .. name .. ".", vim.log.levels.WARN)
    end
  end

  -- Lua
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  })
  enable_if_available("lua_ls", { "lua-language-server" })

  -- HTML, CSS, JSON (vscode-langservers-extracted)
  vim.lsp.config("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    capabilities = capabilities,
  })
  enable_if_available("html", { "vscode-html-language-server" })

  vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    capabilities = capabilities,
  })
  enable_if_available("cssls", { "vscode-css-language-server" })

  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    capabilities = capabilities,
  })
  enable_if_available("jsonls", { "vscode-json-language-server" })

  -- JavaScript / TypeScript
  vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    capabilities = capabilities,
  })
  enable_if_available("ts_ls", { "typescript-language-server" })

  -- Java
  vim.lsp.config("jdtls", {
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_markers = { "pom.xml", "build.gradle", "settings.gradle", ".git" },
    capabilities = capabilities,
  })
  enable_if_available("jdtls", { "jdtls" })
end
