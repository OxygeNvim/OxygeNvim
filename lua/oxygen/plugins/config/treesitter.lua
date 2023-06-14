local treesitter = require('nvim-treesitter.configs')

treesitter.setup(utils.merge({
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
