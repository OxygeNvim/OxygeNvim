-- Don't edit this file!

_G.config = {}

config.keymaps = {
  leader = ' ',
}

config.ui = {
  theme = 'rosepine',
  border = 'rounded',
  transparency = false,
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

  formatters = {
    ['null-ls'] = true,
    jsonls = false,
    sumneko_lua = false,
    tsserver = false,
  },

  servers = {},
}

local ok, user_config = r('config')
if ok then
  _G.config = utils.merge(config, user_config)
end

return config
