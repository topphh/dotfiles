return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "github/copilot.vim" },
    },
    build = "make tiktoken",
    opts = {},
    keys = {
      { "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
      { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
      { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review code" },
      { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code issues" },
      { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
      { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
      { "<leader>zt", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
      { "<leader>zm", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate commit message" },
      { "<leader>zm", ":CopilotChatCommit<CR>", mode = "v", desc = "Generate commit message for selection" },
    },
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
        desc = "Accept Copilot suggestion",
      })

      -- Other Copilot keymaps for navigating suggestions
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })

      -- Additional robust escape handling for Copilot
      vim.keymap.set("i", "<C-c>", function()
        if vim.fn.exists "*copilot#GetDisplayedSuggestion" == 1 then
          local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
          if suggestion.text ~= "" then
            vim.fn["copilot#Dismiss"]()
          end
        end
        return "<C-c>"
      end, { expr = true, desc = "Dismiss Copilot and exit insert mode" })
    end,
  },
}
