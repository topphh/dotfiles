-- Import organized plugin configurations
return {
  -- Import LSP related plugins
  require "plugins.lsp",
  
  -- Import Treesitter plugins  
  require "plugins.treesitter",
  
  -- Import formatting plugins
  require "plugins.formatting",
  
  -- Import Copilot plugins
  require "plugins.copilot",
}
