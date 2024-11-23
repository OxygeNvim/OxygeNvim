local command = vim.api.nvim_create_user_command

command('Format', function()
  vim.lsp.buf.format()
end, {
  desc = 'Format buffer',
})

config.commands(command)
