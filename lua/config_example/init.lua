local M = {}

M.ui = {
  theme = 'tundra',
  border = 'rounded', -- none, single, double, rounded, shadow, solid
  statusline = {
    separator_style = 'rounded', -- default, rounded, solid, arrow
  },
  cmp = {
    style = 'atom_colored', -- default, atom, atom_colored
    kind_text = true,
  },
  highlights = {
    add = {},
    override = {},
  },
}

M.keymaps = {
  leader = ' ',
  custom = {},
}

M.autocmds = function(autocmd)
  -- autocmd("x", "do something")
end

M.commands = function(command)
  -- command("y", "do something")
end

M.lsp = {
  enabled = true,
  format_on_save = true,
  inlay_hints = true,
}

vim.opt.guifont = 'JetBrainsMono Nerd Font'

return M
