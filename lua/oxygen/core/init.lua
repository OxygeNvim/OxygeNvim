for _, module in pairs({
    'editor',
    'autocmds',
    'keymaps',
    'commands',
}) do
  r('oxygen.core.' .. module)
end

vim.cmd('filetype plugin on')

utils.load_keymap('main')
