return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local homebrew_jdtls = "/opt/homebrew/bin/jdtls"

      -- Prefer Homebrew's wrapper here because Mason's wrapper shells out to
      -- plain `java`, which fails on this machine when OpenJDK is not on PATH.
      if vim.fn.executable(homebrew_jdtls) == 1 then
        opts.cmd = { homebrew_jdtls }
      end
    end,
  },
}
