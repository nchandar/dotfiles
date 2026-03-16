-- Keep LazyVim defaults; add a direct launcher for the terminal Git UI.
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

-- Use a tab character for indentation
vim.opt.expandtab = false

-- Number of screen columns for a tab
vim.opt.tabstop = 4

-- Number of spaces to use for auto indentation (e.g., when using >> or ==)
vim.opt.shiftwidth = 4

-- Number of spaces a <Tab> in insert mode counts for (set to tabstop to always use a single tab character)
vim.opt.softtabstop = 4

-- Enable smart indentation (syntax-aware)
vim.opt.smartindent = true
