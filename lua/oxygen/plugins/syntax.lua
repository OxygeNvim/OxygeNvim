local utils = require('oxygen.core.utils')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter',
    build = ':TSUpdateSync',
    cmd = {
      'TSInstall',
      'TSInstallSync',
      'TSInstallInfo',
      'TSInstallFromGrammar',
      'TSUpdate',
      'TSUpdateSync',
      'TSUninstall',
      'TSBufEnable',
      'TSBufDisable',
      'TSBufToggle',
      'TSEnable',
      'TSDisable',
      'TSToggle',
      'TSModuleInfo',
      'TSConfigInfo',
      'TSEditQuery',
      'TSEditQueryUserAfter',
    },
    keys = {
      { '<c-space>', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    init = function()
      utils.lazy_load('nvim-treesitter')
    end,
    opts = {
      ensure_installed = {
        'comment',
        'regex',
      },
      highlight = {
        enable = 1,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    main = 'colorizer',
    event = { 'VeryLazy' },
    opts = {
      filetypes = {
        '*',
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        tailwind = true,
        mode = 'background',
      },
    },
  },
  config = function(_, opts)
    local colorizer = require('colorizer')
    colorizer.setup(opts)

    vim.defer_fn(function()
      colorizer.attach_to_buffer(0)
    end, 0)
  end,
}
