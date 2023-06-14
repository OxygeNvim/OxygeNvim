local treesitter = require('nvim-treesitter.configs')

treesitter.setup(utils.merge({
  ensure_installed = {
    'typescript',
    'javascript',
    'markdown',
    'python',
    'json',
    'yaml',
    'rust',
    'bash',
    'html',
    'tsx',
    'css',
    'vue',
    'lua',
    'c',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  incremental_selection = { enable = true },
  autotag = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  indent = {
    enable = true,
  },
  additional_vim_regex_highlighting = true,
}, config.plugins.config['nvim-treesitter'] or {}))
