require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

vim.o.relativenumber = true
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

----------------------------------------------------------
---------------------Gitsigns-----------------------------
----------------------------------------------------------
local gitsigns = require "gitsigns"
map("n", "<leader>ga", gitsigns.stage_hunk)
map("n", "<leader>gr", gitsigns.reset_hunk)
map("v", "<leader>gs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end)
map("v", "<leader>gr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end)
map("n", "<leader>gS", gitsigns.stage_buffer)
map("n", "<leader>gu", gitsigns.undo_stage_hunk)
map("n", "<leader>gR", gitsigns.reset_buffer)
map("n", "<leader>gp", gitsigns.preview_hunk)
map("n", "<leader>gb", function()
  gitsigns.blame_line { full = true }
end)
map("n", "<leader>glb", gitsigns.toggle_current_line_blame)
map("n", "<leader>gD", function()
  gitsigns.diffthis "~"
end)

-- Navigation
map("n", "]g", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end)
map("n", "[g", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end)

----------------------------------------------------------
---------------------------LSP----------------------------
----------------------------------------------------------

----------------------------------------------------------
-------------------------Diagnostic-----------------------
----------------------------------------------------------
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_prev()
end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
