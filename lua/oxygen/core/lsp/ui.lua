vim.diagnostic.config(utils.merge({
  float = {
    focusable = false,
    style = 'minimal',
    header = { ui.icons.debug .. ' Diagnostics: ', 'Normal' },
    source = 'always',
    border = config.ui.border,
  },
  signs = true,
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
}, config.lsp.options or {}))

local signs = utils.merge({
  Error = ui.icons.error .. ' ',
  Warn = ui.icons.warning .. ' ',
  Hint = ui.icons.hint .. ' ',
  Info = ui.icons.info .. ' ',
}, config.lsp.signs or {})
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type

  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
