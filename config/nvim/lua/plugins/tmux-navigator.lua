return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local map = vim.keymap.set
    local opts = { silent = true }

    map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
    map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
    map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
    map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
    map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", opts)

    map("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
    map("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
    map("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
    map("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)
    map("t", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", opts)
  end,
}
