local indentblankline = require('indent_blankline')

require('base46').load_highlight('blankline')

indentblankline.setup(utils.merge({
  indentLine_enabled = 1,
  char = '▏',
  filetype_exclude = {
    'help',
    'terminal',
    'lspinfo',
    'TelescopePrompt',
    'TelescopeResults',
  },
  buftype_exclude = { 'terminal' },
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = true,
}, config.plugins.config['indent-blankline.nvim'] or {}))
