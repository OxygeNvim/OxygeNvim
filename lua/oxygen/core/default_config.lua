-- Don't edit this file!

_G.config = {}

config.core = {
  branch = 'testing',
}

config.keymaps = {
  leader = ' ',
}

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

config.plugins = {
  add = {},
  remove = {},
  config = {},
}

config.lsp = {
  enabled = true,
  format_on_save = true,
  servers = {},
  formatters = {
    ['null-ls'] = true,
    jsonls = false,
    sumneko_lua = false,
    tsserver = false,
  },
}

local ok, user_config = r('config')
if ok then
  _G.config = utils.merge(config, user_config)
end

return config
