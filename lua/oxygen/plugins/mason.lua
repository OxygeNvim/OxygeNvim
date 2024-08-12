return {
  {
    'williamboman/mason.nvim',
    main = "mason",
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    opts = function()
      local icons = require('oxygen.ui.icons')

      return {
        PATH = 'skip',
        ui = {
          border = config.ui.border,
          icons = {
            package_installed = icons.tick,
            package_pending = '➜',
            package_uninstalled = icons.close,
          },
        },
      }
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('mason')

      require('mason').setup(opts)

      require('mason-lspconfig')
      require('mason-null-ls')
      require('mason-nvim-dap')
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    main = "mason-lspconfig",
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = {
      ensure_installed = {},
    },
  },

  {
    'jay-babu/mason-null-ls.nvim',
    main = "mason-null-ls",
    cmd = { 'NullLsInstall', 'NullLsUninstall' },
    opts = {
      ensure_installed = {},
    },
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    main = "mason-nvim-dap",
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      ensure_installed = {},
    },
  },
}
