return {
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSDisable',
      'TSEnable',
      'TSToggle',
      'TSInstall',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    init = function()
      utils.lazy_load('nvim-treesitter')
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
      ensure_installed = {},
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      indent = {
        enable = true,
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function(_, opts)
      local colorizer = require('colorizer')

      colorizer.setup(opts)

      vim.defer_fn(function()
        colorizer.attach_to_buffer(0)
      end, 0)
    end,
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
}
