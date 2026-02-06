vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

-- Ensure diagnostics are enabled per-buffer when LSP attaches.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.diagnostic.enable(true, { bufnr = args.buf })
  end,
})
