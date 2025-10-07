local M = {}

M.setup = function()
  return {
    -- Chat window configuration
    window = {
      layout = "float", -- 'vertical', 'horizontal', 'float'
      width = 0.8,
      height = 0.8,
      relative = "editor",
      border = "rounded",
    },
    
    -- Disable default mappings to avoid conflicts
    mappings = {
      complete = {
        insert = "",
      },
      close = {
        normal = "q",
        insert = "<C-c>",
      },
      reset = {
        normal = "<C-r>",
        insert = "<C-r>",
      },
      submit_prompt = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      toggle_sticky = {
        detail = "Makes line under cursor sticky or deletes sticky line.",
        normal = "gr",
      },
    },
    
    -- Chat settings
    chat = {
      welcome_message = "Welcome to CopilotChat! 🚀",
      loading_text = "Loading...",
      question_prefix = "## User ",
      answer_prefix = "## Copilot ",
      error_prefix = "## Error ",
    },
    
    -- Context settings
    context = "buffers", -- 'buffers', 'buffer', 'none'
    
    -- Model selection
    model = "gpt-4", -- 'gpt-3.5-turbo', 'gpt-4'
    
    -- Temperature for responses
    temperature = 0.1,
  }
end

return M