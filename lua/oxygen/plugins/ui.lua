return {
  { 'MunifTanjim/nui.nvim', main = 'nui' },

  {
    'nvim-tree/nvim-web-devicons',
    main = 'nvim-web-devicons',
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        override = icons.devicons,
        color_icons = true,
        default = true,
      }
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('devicons')

      require('nvim-web-devicons').setup(opts)
    end,
  },

  {
    'OXY2DEV/helpview.nvim',
    main = 'helpview',
    ft = { 'help' },
    opts = {},
  },

  {
    'nvzone/volt',
    config = function()
      require('oxygen.base46').load_highlight('volt')
    end,
  },
  {
    'nvzone/menu',
    event = { 'VeryLazy' },
    config = function()
      vim.keymap.set('n', '<RightMouse>', function()
        vim.cmd.exec('"normal! \\<RightMouse>"')

        local menu = vim.bo.ft == 'NvimTree' and 'nvimtree' or 'default'
        require('menu').open(menu, { mouse = true })

        require('oxygen.base46').load_highlight('volt')
      end, {})
    end,
  },

  {
    'folke/which-key.nvim',
    main = 'which-key',
    event = { 'VeryLazy' },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      preset = 'helix',
    },
    config = function(_, opts)
      require('oxygen.base46').load_highlight('whichkey')

      require('which-key').setup(opts)
    end,
  },

  {
    'stevearc/aerial.nvim',
    main = 'aerial',
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
    key = {
      { '<leader>a', '', desc = '+Aerial' },
      { '<leader>at', ':AerialToggle<CR>', desc = 'Toggle Aerial' },
    },
    opts = {
      layout = {
        min_width = 35,
      },
    },
    config = function(_, opts)
      require('oxygen.base46').load_highlight('aerial')

      require('aerial').setup(opts)
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'VeryLazy' },
    opts = {},
    config = function(_, opts)
      require('oxygen.base46').load_highlight('blankline')

      vim.opt.list = false

      require('ibl').setup(opts)
    end,
  },

  {
    'folke/todo-comments.nvim',
    main = 'todo-comments',
    event = { 'VeryLazy' },
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        keywords = {
          FIX = {
            icon = icons.debug,
            color = 'error',
            alt = { 'FIXME', 'BUG', 'ISSUE' },
          },
          TODO = { icon = icons.check },
          WARN = { icon = icons.warn, alt = { 'WARNING' } },
        },
      }
    end,
  },

  {
    'declancm/cinnamon.nvim',
    main = 'cinnamon',
    event = { 'VeryLazy' },
    opts = {
      keymaps = {
        basic = true,
        extra = false,
      },
    },
  },

  {
    'akinsho/bufferline.nvim',
    main = 'bufferline',
    event = { 'VeryLazy' },
    keys = {
      { '<TAB>', ':BufferLineCycleNext<CR>', desc = 'Next buffer' },
      { '<S-TAB>', ':BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
      { '<leader>b', '', desc = '+Bufferline' },
      { '<leader>bn', ':BufferLineCycleNext<CR>', desc = 'Next buffer' },
      { '<leader>bp', ':BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
      { '<leader>bo', ':BufferLineCloseOthers<CR>', desc = 'Close other buffers' },
      { '<leader>br', ':BufferLineCloseRight<CR>', desc = 'Close buffers to the right' },
      { '<leader>bl', ':BufferLineCloseLeft<CR>', desc = 'Close buffers to the left' },
    },
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        options = {
          close_command = function(bufnr)
            require('bufdelete').bufdelete(bufnr, true)
          end,
          right_mouse_command = function(bufnr)
            require('bufdelete').bufdelete(bufnr, true)
          end,
          buffer_close_icon = icons.close,
          modified_icon = icons.dot,
          show_close_icon = false,
          left_trunc_marker = icons.left .. ' ',
          right_trunc_marker = icons.right .. ' ',
          max_name_length = 15,
          max_prefix_length = 10,
          tab_size = 15,
          show_tab_indicators = false,
          enforce_regular_tabs = false,
          show_buffer_close_icons = true,
          always_show_bufferline = true,
          offsets = { { filetype = 'NvimTree', text = '', padding = 1, highlight = 'NvimTreeNormal' } },
        },
      }
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('bufferline')

      require('bufferline').setup(opts)
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    main = 'toggleterm',
    cmd = { 'ToggleTerm' },
    keys = {
      { '<leader>f', '', desc = '+ToggleTerm' },
      { '<leader>fo', ':ToggleTerm<CR>', desc = 'Open floating terminal' },
    },
    opts = {
      hide_numbers = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      close_on_exit = true,
      shade_terminals = false,
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    main = 'gitsigns',
    event = { 'VeryLazy' },
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
    config = function(_, opts)
      require('oxygen.base46').load_highlight('git')

      require('gitsigns').setup(opts)
    end,
  },

  {
    'folke/trouble.nvim',
    main = 'trouble',
    cmd = { 'Trouble' },
    keys = {
      {
        '<leader>xx',
        ':Trouble diagnostics toggle<CR>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        ':Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        ':Trouble symbols toggle focus=false<CR>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        ':Trouble s toggle focus=fase win.position=right<CR>',
        desc = 'LSP Definitions (Trouble)',
      },
      {
        '<leader>xL',
        ':Trouble loclist toggle<CR>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        ':Trouble qflist toggle<CR>',
        desc = 'Quickfix List (Trouble)',
      },
    },
    opts = {},
  },

  {
    'rcarriga/nvim-notify',
    main = 'notify',
    event = { 'VeryLazy' },
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        icons = {
          ERROR = icons.error,
          WARN = icons.warn,
          INFO = icons.info,
          DEBUG = icons.debug,
        },
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.25)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.25)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      }
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('notify')

      local notify = require('notify')
      notify.setup(opts)
      vim.notify = notify.notify
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    main = 'telescope',
    cmd = { 'Telescope' },
    keys = {
      { '<leader>t', '', desc = '+Telescope' },
      { '<leader>tt', ':Telescope<CR>', desc = 'Telescope' },
      { '<leader>tf', ':Telescope find_files<CR>', desc = 'Find files' },
      { '<leader>tc', ':Telescope git_commits<CR>', desc = 'Git commits' },
      { '<leader>ts', ':Telescope git_status<CR>', desc = 'Git status' },
    },
    opts = function()
      local icons = require('oxygen.ui.icons')

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
          prompt_prefix = '  ' .. icons.search .. '  ',
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
    config = function(_, opts)
      require('oxygen.base46').load_highlight('telescope')

      require('telescope').setup(opts)
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    main = 'nvim-tree',
    lazy = false,
    cmd = { 'NvimTree', 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeClose' },
    keys = {
      { '<C-n>', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
      { '<C-m>', ':NvimTreeFocus<CR>', desc = 'Focus NvimTree' },
      { '<leader>n', '', desc = '+NvimTree' },
      { '<leader>nt', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
      { '<leader>nf', ':NvimTreeFocus<CR>', desc = 'Focus NvimTree' },
    },
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        hijack_directories = {
          enable = true,
          auto_open = true,
        },
        view = {
          side = 'left',
          width = 35,
          preserve_window_proportions = true,
        },
        git = {
          enable = false,
        },
        renderer = {
          root_folder_modifier = table.concat({ ':t:gs?$?/', string.rep(' ', 1000), '?:gs?^??' }),
          indent_markers = { enable = true },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
            glyphs = icons.nvimtree.glyphs,
          },
        },
      }
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('nvim-tree')

      require('nvim-tree').setup(opts)
    end,
  },

  {
    'luukvbaal/statuscol.nvim',
    main = 'statuscol',
    event = { 'VeryLazy' },
    opts = function()
      local builtin = require('statuscol.builtin')

      return {
        foldfunc = 'builtin',
        setopt = true,
        segments = {
          { text = { ' ', builtin.foldfunc, ' ' }, click = 'v:lua.ScFa', condition = { false, builtin.not_empty } },
          { text = { ' ', '%s' }, click = 'v:lua.ScSa', condition = { false, builtin.not_empty } },

          {
            text = { ' ', builtin.lnumfunc, ' ' },
            condition = { false, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
        },
      }
    end,
  },

  {
    'j-hui/fidget.nvim',
    main = 'fidget',
    event = { 'VeryLazy' },
    opts = function()
      return {
        progress = {
          display = {
            done_icon = require('oxygen.ui.icons').tick,
          },
        },
        notification = {
          window = {
            border = config.ui.border,
            winblend = 10,
          },
        },
      }
    end,
  },

  {
    'ray-x/lsp_signature.nvim',
    main = 'lsp_signature',
    event = { 'InsertEnter' },
    opts = {
      bind = true,
      hint_enable = false,
      handler_opts = {
        border = config.ui.border,
      },
    },
  },
}
