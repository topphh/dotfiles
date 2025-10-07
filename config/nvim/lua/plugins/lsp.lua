return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  -- None-ls for Go
  {
    "nvimtools/none-ls.nvim",
    ft = "go",
    opts = function()
      return require "configs.null-ls"
    end,
  },
}