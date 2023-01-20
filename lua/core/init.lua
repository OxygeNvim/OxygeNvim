for _, module in pairs({
  'core.editor',
  'core.keymaps',
  'core.commands',
}) do
  r(module)
end

vim.cmd('filetype plugin on')

utils.load_keymap('main')
