return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'VeryLazy',
        dependencies = { 'plenary.nvim' },
        config = function(_, opts)
          local null_ls = require('null-ls')

          null_ls.setup(opts)
        end,
        opts = {
          sources = {},
        },
      },
    },
    init = function()
      utils.lazy_load('nvim-lspconfig')
      utils.load_keymap('nvim-lspconfig')
    end,
    config = function(_, opts)
      base46.load_highlight('lsp')

      vim.diagnostic.config({
        float = {
          focusable = false,
          style = 'minimal',
          header = { ui.icons.debug .. ' Diagnostics: ', 'Normal' },
          source = 'always',
          border = config.ui.border,
        },
        signs = true,
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
      })

      local signs = utils.merge({
        Error = ui.icons.error .. ' ',
        Warn = ui.icons.warning .. ' ',
        Hint = ui.icons.hint .. ' ',
        Info = ui.icons.info .. ' ',
      }, config.lsp.signs or {})
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type

        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local defaults = require('oxygen.plugins.lsp.defaults')

      local setup = function(server)
        local server_opts = utils.merge(defaults, opts.servers[server] or {})

        if opts['setup'] then
          if opts.setup[server] then
            if opts.setup[server]() then
              return
            end
          end
        end

        require('lspconfig')[server].setup(server_opts)
      end

      local ok_mason, _ = r('mason')
      local ok_mason_lspconfig, mason_lspconfig = r('mason-lspconfig')
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server_opts.mason == false then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      if ok_mason and ok_mason_lspconfig then
        mason_lspconfig.setup({ ensure_installed = ensure_installed })
        mason_lspconfig.setup_handlers({
          setup,
        })
      end
    end,
    opts = { setup = {}, servers = {} },
  },
}
