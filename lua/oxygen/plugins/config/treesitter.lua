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
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}, config.plugins.config['nvim-treesitter'] or {}))
