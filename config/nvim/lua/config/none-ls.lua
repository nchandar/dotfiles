local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

null_ls.setup({
  sources = {
    -- Lua
    null_ls.builtins.formatting.stylua,

    -- JS/TS/JSON/Markdown/YAML
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint_d,

    -- Shell
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.shellcheck,

    -- Python
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.ruff,

    -- Go
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,

    -- Rust
    null_ls.builtins.formatting.rustfmt,
  },
})
