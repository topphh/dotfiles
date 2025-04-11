-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = {
  "html",
  "cssls",
  "gopls",
  "phpactor",
  "vuels",
  "buf_ls",
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local ooo = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  -- map HERE
  -- vim.keymap.set("n", "gd", "<cmd> Telescope<cr>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr })
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, { buffer = bufnr })
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr })
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = ooo,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
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

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
