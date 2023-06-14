return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    config = function(_, opts)
      base46.load_highlight('mason')

      require('mason').setup(opts)

      require('mason-lspconfig')
      require('mason-null-ls')
    end,
    opts = {
      ui = {
        border = config.ui.border,
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end,
    opts = {
      ensure_installed = {},
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    cmd = { 'NullLsInstall', 'NullLsUninstall' },
    config = function(_, opts)
      require('mason-null-ls').setup(opts)
    end,
    opts = {
      ensure_installed = {},
    },
  },
}
