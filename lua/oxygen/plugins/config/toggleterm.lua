local toggleterm = require('toggleterm')

toggleterm.setup(utils.merge({
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  close_on_exit = true,
  float_opts = {
    border = config.ui.border,
    winblend = 0,
  },
}, config.plugins.config['toggleterm.nvim'] or {}))
