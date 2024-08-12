local utils = require('oxygen.core.utils')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = "nvim-treesitter",
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
    init = function()
      utils.lazy_load('nvim-treesitter')
    end,
    opts = {
      ensure_installed = {
        'comment',
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    main = "colorizer",
    event = { 'VeryLazy' },
    opts = {
      filetypes = {
        '*',
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = false,
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
