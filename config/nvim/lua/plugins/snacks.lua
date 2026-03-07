return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}
      opts.picker.win.input = vim.tbl_deep_extend("force", opts.picker.win.input or {}, {
        -- Work around intermittent picker input WinEnter/BufEnter race on Neovim 0.11.x.
        fixbuf = false,
      })
      return opts
    end,
  },
}
