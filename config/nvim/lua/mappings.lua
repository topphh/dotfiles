require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

vim.o.relativenumber = true
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Robust Esc mapping: Always exit to normal mode regardless of suggestions/completions
map("i", "<Esc>", function()
  -- Check if completion menu is visible and close it
  if vim.fn.pumvisible() == 1 then
    return "<C-e><Esc>"  -- Close completion menu and exit insert mode
  end
  
  -- Check if Copilot suggestion is visible and dismiss it
  if vim.fn.exists('*copilot#GetDisplayedSuggestion') == 1 then
    local suggestion = vim.fn['copilot#GetDisplayedSuggestion']()
    if suggestion.text ~= '' then
      return "<C-c><Esc>"  -- Dismiss copilot and exit insert mode
    end
  end
  
  -- Default escape behavior
  return "<Esc>"
end, { expr = true, desc = "Always exit to normal mode" })

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
map("n", "<leader>gD", gitsigns.diffthis)

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
-- Navigate by SEVERITY (separated by type)
-- ERRORS (highest priority)
vim.keymap.set("n", "[f", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Previous error" })

vim.keymap.set("n", "]f", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Next error" })

-- WARNINGS
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.WARN }
end, { desc = "Previous warning" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN }
end, { desc = "Next warning" })

-- INFORMATION/SUGGESTIONS
vim.keymap.set("n", "[s", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.INFO }
end, { desc = "Previous info/suggestion" })

vim.keymap.set("n", "]s", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.INFO }
end, { desc = "Next info/suggestion" })

-- HINTS/RECOMMENDATIONS
vim.keymap.set("n", "[a", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.HINT }
end, { desc = "Previous hint/recommendation" })

vim.keymap.set("n", "]a", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.HINT }
end, { desc = "Next hint/recommendation" })

-- Diagnostic float and lists
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic to location list" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic to quickfix list" })

----------------------------------------------------------
------------------------CopilotChat-----------------------
----------------------------------------------------------
-- Note: CopilotChat keymaps are defined in plugins/copilot.lua
-- COPILOT INLINE SUGGESTIONS:
-- <C-y>     - Accept Copilot suggestion (insert mode)
-- <C-]>     - Next suggestion (insert mode)
-- <C-[>     - Previous suggestion (insert mode)
-- <C-\>     - Dismiss suggestion (insert mode)
--
-- COPILOT CHAT COMMANDS (z prefix):
-- zc        - Open CopilotChat prompt
-- zt        - Toggle CopilotChat window
-- zf        - Fix code with CopilotChat
-- zo        - Optimize code with CopilotChat
-- zd        - Add documentation with CopilotChat
-- zp        - Generate tests with CopilotChat
-- zr        - Reset CopilotChat
-- ze        - Explain code/selection with CopilotChat

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
