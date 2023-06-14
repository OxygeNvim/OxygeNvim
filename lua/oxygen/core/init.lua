for _, module in pairs({
  'editor',
  'autocmds',
  'keymaps',
}) do
  require('oxygen.core.' .. module)
end

vim.cmd('filetype on')

utils.load_keymap('main')
