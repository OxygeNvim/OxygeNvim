local c = vim.cmd

local modules = {
  'core.editor',
  'core.keymaps',
  'core.commands',
}
for _, module in pairs(modules) do
  r(module)
end

c('filetype plugin on')

vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[%s/\s\+$//e]],
})

utils.load_keymap('main')
