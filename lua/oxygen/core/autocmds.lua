local autocmd = vim.api.nvim_create_autocmd

autocmd('CursorHold *', {
  callback = function()
    vim.diagnostic.open_float(0, { scope = 'line', focusable = false, border = config.ui.border })
  end,
})
