local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File explorer" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- Ctrl shortcuts (more reliable in terminal Neovim)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<C-f>", "/", { desc = "Find in file" })
map("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find in project" })
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<C-b>", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<C-e>", "<cmd>Neotree toggle<cr>", { desc = "File explorer" })
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })

-- Replace still available on <leader>r
map("n", "<leader>r", ":%s//g<Left><Left>", { desc = "Replace in file" })

map("v", "<C-c>", "\"+y", { desc = "Copy selection" })
map("v", "<C-x>", "\"+d", { desc = "Cut selection" })
map({ "n", "v" }, "<C-v>", "\"+p", { desc = "Paste" })
map("n", "<C-c>", "\"+yy", { desc = "Copy line" })
map("n", "<C-x>", "\"+dd", { desc = "Cut line" })
map("n", "<C-d>", "\"_dd", { desc = "Delete line (no yank)" })
map("v", "<C-d>", "\"_d", { desc = "Delete selection (no yank)" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- LSP keymaps (buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", function()
      local clients = vim.lsp.get_clients({ bufnr = buf })
      if not clients or vim.tbl_isempty(clients) then
        vim.notify("No LSP attached for this buffer.", vim.log.levels.WARN)
        return
      end
      vim.lsp.buf.code_action()
    end, opts)
  end,
})
