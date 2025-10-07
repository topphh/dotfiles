return {
  -- CopilotChat with custom configuration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "github/copilot.vim" }, -- Make sure we have the base copilot
    },
    build = "make tiktoken",
    opts = function()
      return require("configs.copilot").setup()
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)
      
      -- Custom keymaps for CopilotChat (all using z prefix)
      vim.keymap.set("n", "zc", ":CopilotChat ", { desc = "CopilotChat - Open chat" })
      vim.keymap.set("n", "zt", ":CopilotChatToggle<CR>", { desc = "CopilotChat - Toggle chat" })
      vim.keymap.set("n", "zf", ":CopilotChatFix<CR>", { desc = "CopilotChat - Fix code" })
      vim.keymap.set("n", "zo", ":CopilotChatOptimize<CR>", { desc = "CopilotChat - Optimize code" })
      vim.keymap.set("n", "zd", ":CopilotChatDocs<CR>", { desc = "CopilotChat - Add documentation" })
      vim.keymap.set("n", "zp", ":CopilotChatTests<CR>", { desc = "CopilotChat - Generate tests" })
      vim.keymap.set("n", "zr", ":CopilotChatReset<CR>", { desc = "CopilotChat - Reset chat" })
      
      -- Explain code keymaps using z prefix
      vim.keymap.set("n", "ze", function()
        chat.ask("Explain this code", { selection = require("CopilotChat.select").buffer })
      end, { desc = "CopilotChat - Explain current buffer" })
      
      vim.keymap.set("v", "ze", function()
        chat.ask("Explain this code", { selection = require("CopilotChat.select").visual })
      end, { desc = "CopilotChat - Explain selection" })
    end,
  },
  
  -- Base GitHub Copilot for inline suggestions
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default tab mapping since NvChad uses it
      vim.g.copilot_no_tab_map = true
      
      -- Set custom accept mapping to <C-y> in insert mode (avoids <C-z> suspend conflict)
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
      
      -- Other Copilot keymaps for navigating suggestions
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
      
      -- Additional robust escape handling for Copilot
      vim.keymap.set("i", "<C-c>", function()
        if vim.fn.exists('*copilot#GetDisplayedSuggestion') == 1 then
          local suggestion = vim.fn['copilot#GetDisplayedSuggestion']()
          if suggestion.text ~= '' then
            vim.fn['copilot#Dismiss']()
          end
        end
        return "<C-c>"
      end, { expr = true, desc = "Dismiss Copilot and exit insert mode" })
    end,
  },
}