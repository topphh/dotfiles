-- Load defaults (nvchad-specific)
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "html",
  "cssls", 
  "phpactor",
  "vuels",
  "buf_ls",
}

-- Setup servers using vim.lsp.enable to avoid deprecation warning
for _, server in ipairs(servers) do
  vim.lsp.enable(server, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

-- Custom setup for gopls with extra keybindings using vim.lsp.enable
vim.lsp.enable("gopls", {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)

    -- Extra keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = function(fname)
    local util = require "lspconfig.util"
    return util.root_pattern("go.work", "go.mod", ".git")(fname)
  end,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

