local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local sources = {}
local function add(source)
  if source then
    table.insert(sources, source)
  end
end

local b = null_ls.builtins

local function from_extras(path)
  local ok_extras, extras = pcall(require, path)
  if ok_extras then
    return extras
  end
  return nil
end

-- Lua
add(b.formatting.stylua)

-- JS/TS/JSON/Markdown/YAML
add(b.formatting.prettier)
add(from_extras("none-ls.diagnostics.eslint_d"))

-- Shell
add(b.formatting.shfmt)
add(from_extras("none-ls.diagnostics.shellcheck"))

-- Python
add(b.formatting.black)
add(from_extras("none-ls.diagnostics.ruff"))

-- Go
add(b.formatting.gofmt)
add(b.formatting.goimports)

-- Rust
add(from_extras("none-ls.formatting.rustfmt"))

null_ls.setup({
  sources = sources,
})
