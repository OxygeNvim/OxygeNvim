local command = vim.api.nvim_create_user_command

command('OxygenSync', extensions.updater.update.all, {
  desc = 'Updates configuration and plugins',
})

command('Format', function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = 'Formats the current file if lsp is available and has formatting support',
})
