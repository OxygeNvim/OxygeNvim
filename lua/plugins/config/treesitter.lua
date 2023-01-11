local treesitter = require('nvim-treesitter.configs')

require('base46').load_highlight('treesitter')

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
