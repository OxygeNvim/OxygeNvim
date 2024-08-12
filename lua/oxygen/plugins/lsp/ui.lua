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
  signs = true,
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})

for type, icon in pairs({
  Error = icons.error .. ' ',
  Warn = icons.warn .. ' ',
  Hint = icons.hint .. ' ',
  Info = icons.info .. ' ',
}) do
  local hl = 'DiagnosticSign' .. type

  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
