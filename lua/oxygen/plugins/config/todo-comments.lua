local todocomments = require('todo-comments')

todocomments.setup(utils.merge({
  keywords = {
    FIX = {
      icon = ui.icons.debug,
      color = 'error',
      alt = { 'FIXME', 'BUG', 'ISSUE' },
    },
    TODO = { icon = ui.icons.check },
    WARN = { icon = ui.icons.warn, alt = { 'WARNING' } },
  },
}, config.plugins.config['todo-comments.nvim'] or {}))
