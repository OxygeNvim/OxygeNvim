require('oxygen.base46').load_highlight('lsp')

local icons = require('oxygen.ui.icons')

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = config.ui.border,
  focusable = false,
  relative = 'cursor',
  silent = true,
})

vim.diagnostic.config({
  float = {
    focusable = false,
    style = 'minimal',
    header = { icons.debug .. ' Diagnostics: ', 'Normal' },
    border = config.ui.border,
  },
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error .. " ",
      [vim.diagnostic.severity.WARN] = icons.warn .. " ",
      [vim.diagnostic.severity.HINT] = icons.hint .. " ",
      [vim.diagnostic.severity.INFO] = icons.info .. " ",
    }
  }
})
