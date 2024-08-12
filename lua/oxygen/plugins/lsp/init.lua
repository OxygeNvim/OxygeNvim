local utils = require('oxygen.core.utils')

return {
  {
    'neovim/nvim-lspconfig',
    main = 'lspconfig',
    dependencies = {
      {
        'nvimtools/none-ls.nvim',
        main = 'null-ls',
        event = { 'VeryLazy' },
        opts = {
          sources = {},
        },
      },
    },
    keys = {
      {
        '<leader>g',
        '',
        desc = '+LSP',
      },
      {
        '<leader>gD',
        function()
          vim.lsp.buf.declaration()
        end,
        desc = 'LSP declaration',
      },
      {
        '<leader>gd',
        function()
          vim.lsp.buf.definition()
        end,
        desc = 'LSP definition',
      },
      {
        '<leader>gi',
        function()
          vim.lsp.buf.implementation()
        end,
        desc = 'LSP implementation',
      },
      {
        '<leader>gh',
        function()
          vim.lsp.buf.signature_help()
        end,
        desc = 'LSP signature_help',
      },
      {
        '<leader>gt',
        function()
          vim.lsp.buf.type_definition()
        end,
        desc = 'LSP definition type',
      },
      {
        '<leader>ga',
        function()
          vim.lsp.buf.code_action()
        end,
        desc = 'LSP code_action',
      },
      {
        '<leader>gr',
        function()
          vim.lsp.buf.references()
        end,
        desc = 'LSP references',
      },
      {
        '<leader>d',
        '',
        desc = '+Diagnostics',
      },
      {
        '<leader>dp',
        function()
          vim.diagnostic.jump({
            count = -1,
          })
        end,
        desc = 'Previous diagnostic',
      },
      {
        '<leader>dn',
        function()
          vim.diagnostic.jump({
            count = 1,
          })
        end,
        desc = 'Next diagnostic',
      },
      {
        '<leader>r',
        '',
        desc = '+Rename',
      },
      {
        '<leader>rn',
        function()
          vim.lsp.buf.rename()
        end,
        desc = 'LSP rename',
      },
    },
    init = function()
      utils.lazy_load('nvim-lspconfig')
    end,
    opts = { servers = {} },
    config = function(_, opts)
      require('oxygen.plugins.lsp.ui')

      local defaults = require('oxygen.plugins.lsp.defaults')
      local lspconfig = require('lspconfig')
      for server, server_opts in pairs(opts.servers) do
        server_opts = table.merge(defaults, server_opts)

        server_opts.on_attach = function(client, bufnr)
          defaults.on_attach(client, bufnr)

          if opts.servers[server].on_attach then
            opts.servers[server].on_attach(client, bufnr)
          end
        end

        lspconfig[server].setup(server_opts)
      end
    end,
  },
}
