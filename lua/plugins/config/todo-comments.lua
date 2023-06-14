local todocomments = require('todo-comments')

todocomments.setup(utils.merge({
  keywords = {
    FIX = {
      icon = ui.icons.debug,
      color = 'error',
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
    },
    TODO = { icon = ui.icons.check },
    WARN = { icon = ui.icons.warn, alt = { 'WARNING', 'XXX' } },
  },
}, config.plugins.config['todo-comments.nvim'] or {}))
