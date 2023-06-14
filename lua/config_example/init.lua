local M = {}

M.ui = {
  theme = 'tundra',
  border = 'single', -- rounded, single, double
  cmp_style = 'atom', -- default, atom, bordered
  statusline = {
    separator_style = 'round', -- default | round | block | arrow
  },
}

-- adds LSP and treesitter support for the specified languages
M.languages = {
  'c',
  'go',
  'java',
  'javascript',
  'json',
  'lua',
  'python',
  'react',
  'rust',
  'shell',
  'vue',
  'web',
  'yaml',
}

M.keymaps = {
  leader = ' ',
  custom = {
    -- mode of keymap (i, n, v, t)
    n = {
      -- 1. The keybinding
      -- 2. The command
      -- 3. Description (optional)
      ['<C-n>'] = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
    },
  },
}

M.lsp = {
  enabled = true,
  format_on_save = true,
}

return M
