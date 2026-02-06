local M = {}

local function default_ft_to_lang(ft)
  local ts = vim.treesitter
  if ts and ts.language and ts.language.get_lang then
    local ok, lang = pcall(ts.language.get_lang, ft)
    if ok and lang then
      return lang
    end
  end
  return ft
end

local function treesitter_index(_, key)
  if key == "ft_to_lang" then
    return default_ft_to_lang
  end
end

function M.ensure_ft_to_lang()
  if type(vim.treesitter) ~= "table" then
    vim.treesitter = {}
  end
  local mt = getmetatable(vim.treesitter)
  if not mt then
    mt = {}
    setmetatable(vim.treesitter, mt)
  end
  if not mt.__index then
    mt.__index = treesitter_index
  end
  if not rawget(vim.treesitter, "ft_to_lang") then
    vim.treesitter.ft_to_lang = default_ft_to_lang
  end
end

M.ensure_ft_to_lang()

return M
