-- Load defaults (nvchad-specific)
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "html",
  "cssls",
  "phpactor",
  "vuels",
  "buf_ls",
}

-- Setup all other servers using default `nvchad` on_attach
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom setup for gopls with extra keybindings
lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)

    -- Extra keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

