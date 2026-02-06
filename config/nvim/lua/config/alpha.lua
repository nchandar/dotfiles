local ok, alpha = pcall(require, "alpha")
if not ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- Header
local logo = {
  [[██████   █████ ██████████    ███████    █████   █████ █████ ██████   ██████]],
  [[░░██████ ░░███ ░░███░░░░░█  ███░░░░░███ ░░███   ░░███ ░░███ ░░██████ ██████ ]],
  [[ ░███░███ ░███  ░███  █ ░  ███     ░░███ ░███    ░███  ░███  ░███░█████░███ ]],
  [[ ░███░░███░███  ░██████   ░███      ░███ ░███    ░███  ░███  ░███░░███ ░███ ]],
  [[ ░███ ░░██████  ░███░░█   ░███      ░███ ░░███   ███   ░███  ░███ ░░░  ░███ ]],
  [[ ░███  ░░█████  ░███ ░   █░░███     ███   ░░░█████░    ░███  ░███      ░███ ]],
  [[ █████  ░░█████ ██████████ ░░░███████░      ░░███      █████ █████     █████]],
  [[░░░░░    ░░░░░ ░░░░░░░░░░    ░░░░░░░         ░░░      ░░░░░ ░░░░░     ░░░░░ ]],
}

vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa", bold = true })

dashboard.section.header.val = logo
dashboard.section.header.opts = vim.tbl_extend(
  "force",
  dashboard.section.header.opts or {},
  { hl = "AlphaHeader", position = "center" }
)

-- Buttons
local function button(sc, txt, keybind)
  return dashboard.button(sc, txt, keybind)
end

dashboard.section.buttons.val = {
  button("f", "  Find File", ":Telescope find_files<CR>"),
  button("n", "  New File", ":ene | startinsert<CR>"),
  button("g", "  Find Text", ":Telescope live_grep<CR>"),
  button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
  button("c", "  Config", ":Telescope find_files cwd=~/.config/nvim<CR>"),
  button("l", "󰒲  Lazy", ":Lazy<CR>"),
  button("q", "  Quit", ":qa<CR>"),
}
dashboard.section.buttons.opts = vim.tbl_extend(
  "force",
  dashboard.section.buttons.opts or {},
  { position = "center" }
)

-- Footer
local function footer()
  local v = vim.version()
  return "Neovim " .. v.major .. "." .. v.minor .. "." .. v.patch
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts = vim.tbl_extend(
  "force",
  dashboard.section.footer.opts or {},
  { position = "center" }
)

local function top_padding()
  local h = vim.fn.winheight(0)
  return math.max(1, math.floor(h * 0.12))
end

dashboard.config.layout = {
  { type = "padding", val = top_padding },
  dashboard.section.header,
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

alpha.setup(dashboard.config)

-- Show Alpha on startup when no file is specified.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local function only_dirs()
      local args = vim.fn.argv()
      if #args == 0 then
        return true
      end
      for _, arg in ipairs(args) do
        if vim.fn.isdirectory(arg) == 0 then
          return false
        end
      end
      return true
    end

    local function start_alpha_with_tree()
      require("alpha").start(true)
      vim.schedule(function()
        pcall(vim.cmd, "Neotree show")
      end)
    end

    if only_dirs() then
      local first = vim.fn.argv(0)
      if first and vim.fn.isdirectory(first) == 1 then
        vim.cmd("cd " .. vim.fn.fnameescape(first))
      end
      vim.cmd("enew")
      vim.defer_fn(function()
        start_alpha_with_tree()
      end, 20)
      return
    end
  end,
})

-- Disable folding on alpha buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.foldenable = false
  end,
})
