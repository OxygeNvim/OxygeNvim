return {
  { 'MunifTanjim/nui.nvim' },

  {
    'nvim-tree/nvim-web-devicons',
    config = function(_, opts)
      base46.load_highlight('devicons')
      require('nvim-web-devicons').setup(opts)
    end,
    opts = function()
      return {
        override = ui.icons.devicons,
        color_icons = true,
        default = true,
      }
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      base46.load_highlight('whichkey')
      require('which-key').setup(opts)
    end,
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = false,
        },
      },
      operators = { gc = 'Comments' },
      window = {
        border = 'none',
        position = 'bottom',
        margin = { 0, 0, 1, 0 },
        padding = { 0, 1, 1, 0 },
        winblend = 10,
      },
      hidden = { '<silent>', '<cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
    },
  },

  {
    'stevearc/aerial.nvim',
    cmd = {
      'AerialToggle',
      'AerialOpen',
      'AerialOpenAll',
      'AerialClose',
      'AerialCloseAll',
      'AerialNext',
      'AerialPrev',
      'AerialInfo',
    },
    init = function()
      utils.load_keymap('aerial.nvim')
    end,
    config = function(_, opts)
      base46.load_highlight('aerial')
      require('aerial').setup(opts)
    end,
    opts = {
      layout = {
        min_width = 40,
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    init = function()
      utils.lazy_load('indent-blankline.nvim')
    end,
    config = function(_, opts)
      vim.opt.list = false

      base46.load_highlight('blankline')
      require('indent_blankline').setup(opts)
    end,
    opts = {
      indentLine_enabled = 1,
      char = '│',
      context_char = '│',
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      buftype_exclude = { 'terminal' },
      filetype_exclude = {
        'help',
        'terminal',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
        'mason',
        'lazy',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'gitsigns.nvim', 'plenary.nvim' },
    config = function(_, opts)
      require('todo-comments').setup(opts)
    end,
    opts = function()
      return {
        keywords = {
          FIX = {
            icon = ui.icons.debug,
            color = 'error',
            alt = { 'FIXME', 'BUG', 'ISSUE' },
          },
          TODO = { icon = ui.icons.check },
          WARN = { icon = ui.icons.warn, alt = { 'WARNING' } },
        },
      }
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-web-devicons' },
    init = function()
      utils.load_keymap('bufferline.nvim')
    end,
    config = function(_, opts)
      base46.load_highlight('bufferline')
      require('bufferline').setup(opts)
    end,
    opts = function()
      return {
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
      }
    end,
  },

  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      require('neoscroll').setup(opts)
    end,
    opts = {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = nil,
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    },
  },

  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    init = function()
      utils.load_keymap('toggleterm.nvim')
    end,
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
    opts = {
      hide_numbers = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      close_on_exit = true,
      float_opts = {
        border = config.ui.border,
        winblend = 0,
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function(_, opts)
      base46.load_highlight('git')

      require('gitsigns').setup(opts)
    end,
    opts = {
      signcolumn = true,
      preview_config = {
        border = config.ui.border,
        style = 'minimal',
      },
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '│' },
        topdelete = { text = '│' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'popup.nvim',
      'plenary.nvim',
    },
    init = function()
      utils.load_keymap('telescope.nvim')
    end,
    config = function(_, opts)
      base46.load_highlight('telescope')

      require('telescope').setup(opts)
    end,
    opts = function()
      return {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          prompt_prefix = '  ' .. ui.icons.search .. '  ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'bottom',
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { 'node_modules' },
          path_display = { 'truncate' },
          winblend = 0,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' },
          file_sorter = require('telescope.sorters').get_fuzzy_file,
          generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
          buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
          mappings = {
            n = { ['q'] = require('telescope.actions').close },
          },
        },
      }
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTree', 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeClose' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      utils.load_keymap('nvim-tree.lua')
    end,
    config = function(_, opts)
      base46.load_highlight('nvimtree')
      require('nvim-tree').setup(opts)
    end,
    opts = function()
      return {
        filters = {
          dotfiles = false,
        },
        disable_netrw = true,
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
            glyphs = ui.icons.nvimtree.glyphs,
          },
        },
      }
    end,
  },
}
