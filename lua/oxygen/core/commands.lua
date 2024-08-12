local command = vim.api.nvim_create_user_command

command('Format', function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = 'Format file',
})

config.commands(command)
