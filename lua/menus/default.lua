return {
  {
    name = 'Inspect',
    cmd = 'Inspect',
  },

  { name = 'separator' },

  {
    name = 'Format Buffer',
    cmd = function()
      vim.lsp.buf.format()
    end,
    rtxt = '<leader>fm',
  },

  {
    name = 'Code Actions',
    cmd = vim.lsp.buf.code_action,
    rtxt = '<leader>ga',
  },

  { name = 'separator' },

  {
    name = require('oxygen.ui.icons').cog .. ' Lsp Actions',
    hl = 'Exblue',
    items = 'lsp',
  },

  { name = 'separator' },

  {
    name = 'Copy all',
    cmd = '%y+',
    rtxt = '<C-c>',
  },

  {
    name = 'Cut all',
    cmd = '%d+',
    rtxt = '<C-c>',
  },
}
