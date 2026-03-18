return {
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.java" },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug Toggle Breakpoint" },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug Conditional Breakpoint",
      },
    },
  },
}
