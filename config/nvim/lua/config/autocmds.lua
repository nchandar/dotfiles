-- Close certain popups with Esc
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lazy" },
  callback = function()
    vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = true, silent = true })
  end,
})
