local bufferline = require('bufferline')

require('base46').load_highlight('bufferline')

bufferline.setup(utils.merge({
  options = {
    buffer_close_icon = ui.icons.close,
    modified_icon = ui.icons.dot,
    show_close_icon = false,
    left_trunc_marker = ui.icons.left .. ' ',
    right_trunc_marker = ui.icons.right .. ' ',
    max_name_length = 15,
    max_prefix_length = 10,
    tab_size = 15,
    show_tab_indicators = false,
    enforce_regular_tabs = false,
    show_buffer_close_icons = true,
    always_show_bufferline = true,
    offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
  },
}, config.plugins.config['bufferline.nvim'] or {}))
