local mason = require('mason')

vim.api.nvim_create_augroup('_mason', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'mason',
  callback = function()
    require('base46').load_highlight('mason')
  end,
  group = '_mason',
})

mason.setup(utils.merge({
  ui = {
    border = config.ui.border,
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
}, config.plugins.config['mason'] or {}))
