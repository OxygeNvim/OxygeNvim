local command = vim.api.nvim_create_user_command

command('OxygenSync', extensions.updater, {
  desc = 'Update OxygeNvim',
})

command('Format', function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = 'Formats the current file if lsp is available and has formatting support',
})
