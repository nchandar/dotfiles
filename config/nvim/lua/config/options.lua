local opt = vim.opt

-- Keep a few preferences from the old setup; everything else stays LazyVim default.
opt.timeoutlen = 400
opt.updatetime = 250
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
