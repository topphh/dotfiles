local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  sources = {
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports_reviser,
    --null_ls.builtins.formatting.golines,
  },

  -- format on save
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })

      -- Keybinding to format and organize imports
      vim.keymap.set("n", "<leader>gli", function()
        vim.lsp.buf.format { bufnr = bufnr }
      end, { buffer = bufnr, desc = "Go: organize imports" })

    end
  end,
}
