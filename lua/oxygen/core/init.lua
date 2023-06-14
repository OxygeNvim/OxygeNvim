for _, module in pairs({
  'editor',
  'autocmds',
  'keymaps',
  'commands',
}) do
  require('oxygen.core.' .. module)
end

if not utils.filesystem.check_dir(vim.fn.stdpath('cache') .. '/oxygen') then
  utils.filesystem.create_dir(vim.fn.stdpath('cache') .. '/oxygen')
end

vim.cmd('filetype on')

utils.load_keymap('main')
