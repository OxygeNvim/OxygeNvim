local nvimtree = require('nvim-tree')
local icons = require('core.ui.icons')

require('base46').load_highlight('nvimtree')

nvimtree.setup(utils.merge({
  filters = {
    dotfiles = false,
  },
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    side = 'left',
    hide_root_folder = false,
  },
  git = {
    enable = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    add_trailing = false,
    root_folder_modifier = table.concat({ ':t:gs?$?/', string.rep(' ', 1000), '?:gs?^??' }),
    highlight_git = false,
    highlight_opened_files = 'none',
    indent_markers = {
      enable = false,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = icons.nvimtree.glyphs,
    },
  },
}, config.plugins.config['nvim-tree.lua'] or {}))
