local utils = require('oxygen.core.utils')

local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'CursorHold' }, {
  group = utils.create_augroup('CursorHoldDiagnosticFloat'),
  callback = function()
    vim.diagnostic.open_float({
      bufnr = 0,
    })
  end,
})

config.autocmds(autocmd)
