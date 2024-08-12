-- Don't edit this file!

local utils = require('oxygen.core.utils')

_G.config = {}

config.dev = false

config.ui = {
  theme = 'tundra',
  border = 'rounded',
  cmp_style = 'default',
  highlights = {
    add = {},
    override = {},
  },
  statusline = {
    separator_style = 'default',
  },
}

config.core = {
  branch = 'main',
}

config.keymaps = {
  leader = ' ',
  custom = {},
}

config.autocmds = function() end

config.commands = function() end

config.lsp = {
  enabled = true,
  format_on_save = true,
  inlay_hints = true,
}

local ok, user_config = utils.r('config')
if ok then
  _G.config = table.merge(config, user_config)
end

return config
