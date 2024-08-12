local keymaps = table.merge({
  { '<CS-d>', '<C-o>:normal!"-Y"-p<CR>', mode = 'i' },
  { '<C-g><C-w>', '<C-o>vgw', mode = 'i' },
  { '<C-J>', '<C-o>J', mode = 'i' },

  { '<ESC>', ':noh<CR>' },
  { '<C-s>', ':w<CR>', desc = 'Save file' },

  { 'p', 'p:let @+=@-1<CR>', mode = 'v' },
}, config.keymaps.custom or {})

vim.g.mapleader = config.keymaps.leader
vim.g.maplocalleader = config.keymaps.leader

for _, keymap in pairs(keymaps) do
  vim.keymap.set(
    keymap['mode'] or 'n',
    keymap[1],
    keymap[2],
    { noremap = true, silent = true, desc = keymap['desc'] or '' }
  )
end
