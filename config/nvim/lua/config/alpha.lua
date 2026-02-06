local ok, alpha = pcall(require, "alpha")
if not ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- Header
local logo = {
  [[      _   __            _           ]],
  [[     / | / /___ _   __ (_)___  ____ ]],
  [[    /  |/ / __ \ | / // / __ \/ __ \]],
  [[   / /|  / /_/ / |/ // / / / / /_/ /]],
  [[  /_/ |_/\____/|___//_/_/ /_/ .___/ ]],
  [[                           /_/       ]],
}

dashboard.section.header.val = logo

-- Buttons
local function button(sc, txt, keybind)
  return dashboard.button(sc, txt, keybind)
end

dashboard.section.buttons.val = {
  button("f", "Find file", ":Telescope find_files<CR>"),
  button("g", "Live grep", ":Telescope live_grep<CR>"),
  button("r", "Recent files", ":Telescope oldfiles<CR>"),
  button("n", "New file", ":enew<CR>"),
  button("c", "Config", ":edit ~/.config/nvim/init.lua<CR>"),
  button("l", "Lazy", ":Lazy<CR>"),
  button("q", "Quit", ":qa<CR>"),
}

-- Footer
local function footer()
  local v = vim.version()
  return "Neovim " .. v.major .. "." .. v.minor .. "." .. v.patch
end

dashboard.section.footer.val = footer()

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
