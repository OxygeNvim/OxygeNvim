return {
  { 'nvim-lua/plenary.nvim', main = 'plenary' },

  {
    'famiu/bufdelete.nvim',
    main = 'bufdelete',
    keys = {
      {
        '<leader>x',
        function()
          require('bufdelete').bufdelete(0, true)
        end,
        desc = 'Close current buffer',
      },
    },
  },

  {
    'numToStr/Comment.nvim',
    main = 'Comment',
    keys = { { 'gc', mode = { 'v' } }, { 'gb', mode = { 'v' } }, { 'gc' } },
    dependencies = {
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    config = function(_, opts)
      require('ts_context_commentstring').setup()
      require('Comment').setup(opts)
    end,
  },

  {
    'nacro90/numb.nvim',
    main = 'numb',
    event = { 'CmdlineEnter' },
    opts = {},
  },

  {
    'stevearc/overseer.nvim',
    main = 'overseer',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    keys = {
      { '<leader>o', '', desc = '+Overseer' },
      { '<leader>ot', ':OverseerToggle<CR>', desc = 'Task list' },
      { '<leader>oo', ':OverseerRun<CR>', desc = 'Run task' },
      { '<leader>oq', ':OverseerQuickAction<CR>', desc = 'Action recent task' },
      { '<leader>oi', ':OverseerInfo<CR>', desc = 'Overseer Info' },
      { '<leader>ob', ':OverseerBuild<CR>', desc = 'Task builder' },
      { '<leader>oa', ':OverseerTaskAction<CR>', desc = 'Task action' },
      { '<leader>oc', ':OverseerClearCache<CR>', desc = 'Clear cache' },
    },
    opts = {
      dap = false,
      strategy = 'toggleterm',
      form = {
        border = config.ui.border,
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        border = config.ui.border,
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        border = config.ui.border,
        win_opts = {
          winblend = 0,
        },
      },
    },
  },

  {
    'stevearc/resession.nvim',
    main = 'resession',
    lazy = false,
    opts = {
      extensions = {
        overseer = {},
      },
    },
    keys = {
      { '<leader>s', '', desc = '+Session' },
      {
        '<leader>ss',
        function()
          require('resession').save()
        end,
        desc = 'Save session',
      },
      {
        '<leader>sl',
        function()
          require('resession').load()
        end,
        desc = 'Load session',
      },
      {
        '<leader>sd',
        function()
          require('resession').delete()
        end,
        desc = 'Delete session',
      },
    },
  },

  {
    'ellisonleao/carbon-now.nvim',
    main = 'carbon-now',
    cmd = { 'CarbonNow' },
    opts = function()
      local ui_utils = require('oxygen.ui.utils')
      local file_name = ui_utils.get_file_name()

      return {
        options = {
          bg = 'orange',
          font_family = 'JetBrains Mono',
          theme = 'one-light',
          window_theme = 'none',
          font_size = '15px',
          line_height = '150%',
          titlebar = file_name,
        },
      }
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    main = 'ufo',
    event = { 'VeryLazy' },
    dependencies = { { 'kevinhwang91/promise-async' } },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'CLose all folds',
      },
    },
    opts = {},
  },
}
