local autocmd = vim.api.nvim_create_autocmd

autocmd('CursorHold *', {
  callback = function()
    vim.diagnostic.open_float(0)
  end,
})
