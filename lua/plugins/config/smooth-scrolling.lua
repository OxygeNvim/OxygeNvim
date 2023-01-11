local cinnamon = require('cinnamon')

cinnamon.setup(utils.merge({
  default_keymaps = true,
  extra_keymaps = true,
  extended_keymaps = true,
  override_keymaps = true,
}, config.plugins.config['cinnamon.nvim'] or {}))
