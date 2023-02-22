local cmp = not utils.disable_plugin('nvim-cmp')

local plugins = {
  {
    'folke/lazy.nvim',
    config = function()
      base46.load_highlight('lazy')
    end,
  },

  {
    dir = 'OxygeNvim/base46',
    lazy = false,
    priority = 1000,
    config = function()
      require('oxygen.base46')
      base46.setup()
    end,
  },

  {
    dir = 'OxygeNvim/ui',
    lazy = false,
    config = function()
      require('oxygen.ui')
      ui.setup()
    end,
  },

  { 'nvim-lua/plenary.nvim' },
  { 'MunifTanjim/nui.nvim' },

  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('oxygen.plugins.config.other').devicons()
    end,
  },

  {
    'famiu/bufdelete.nvim',
    init = function()
      utils.load_keymap('bufdelete.nvim')
    end,
    enabled = not utils.disable_plugin('bufdelete.nvim'),
  },

  {
    'gpanders/editorconfig.nvim',
    event = 'VeryLazy',
    config = function()
      require('oxygen.plugins.config.other').editorconfig()
    end,
    enabled = not utils.disable_plugin('editorconfig.nvim'),
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('oxygen.plugins.config.other').which_key()
    end,
    enabled = not utils.disable_plugin('which-key.nvim'),
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
    config = function()
      require('oxygen.plugins.config.other').aerial()
    end,
    init = function()
      utils.load_keymap('aerial.nvim')
    end,
    enabled = not utils.disable_plugin('aerial.nvim'),
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('oxygen.plugins.config.other').colorizer()
    end,
    enabled = not utils.disable_plugin('nvim-colorizer.lua'),
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('oxygen.plugins.config.telescope')
    end,
    init = function()
      utils.load_keymap('telescope.nvim')
    end,
    enabled = not utils.disable_plugin('telescope.nvim'),
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = false
      require('oxygen.plugins.config.indent-blankline')
    end,
    init = function()
      utils.lazy_load('indent-blankline.nvim')
    end,
    enabled = not utils.disable_plugin('indent-blankline.nvim'),
  },

  { 'JoosepAlviste/nvim-ts-context-commentstring', enabled = not utils.disable_plugin('nvim-treesitter') },

  {
    'nvim-treesitter/nvim-treesitter',
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSEnable', 'TSDisable', 'TSModuleInfo' },
    dependencies = {
      { 'windwp/nvim-ts-autotag' },
    },
    config = function()
      require('oxygen.plugins.config.treesitter')
    end,
    init = function()
      utils.lazy_load('nvim-treesitter')
    end,
    enabled = not utils.disable_plugin('nvim-treesitter'),
  },

  {
    'lewis6991/gitsigns.nvim',
    ft = 'gitcommit',
    config = function()
      require('oxygen.plugins.config.other').gitsigns()
    end,
    init = function()
      vim.api.nvim_create_autocmd({ 'BufRead' }, {
        group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
        callback = function()
          vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse')
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name('GitSignsLazyLoad')
            vim.schedule(function()
              require('lazy').load({ plugins = 'gitsigns.nvim' })
            end, 0)
          end
        end,
      })
    end,
    enabled = not utils.disable_plugin('gitsigns.nvim'),
  },

  {
    'fedepujol/move.nvim',
    cmd = {
      'MoveLine',
      'MoveBlock',
    },
    init = function()
      utils.load_keymap('move.nvim')
    end,
    enabled = not utils.disable_plugin('move.nvim'),
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('oxygen.plugins.config.other').comment()
    end,
    init = function()
      utils.load_keymap('Comment.nvim')
    end,
    enabled = not utils.disable_plugin('Comment.nvim'),
  },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('oxygen.plugins.config.todo-comments')
    end,
    enabled = not utils.disable_plugin('todo-comments.nvim'),
  },

  {
    'b0o/SchemaStore.nvim',
    ft = 'json',
    enabled = config.lsp.enabled,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('oxygen.core.lsp.servers.null_ls')
        end,
        enabled = not utils.disable_plugin('null-ls.nvim'),
      },
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
        dependencies = {
          { 'williamboman/mason-lspconfig.nvim', cmd = { 'LspInstall', 'LspUninstall' } },
        },
        config = function()
          require('oxygen.plugins.config.mason')
        end,
        enabled = not utils.disable_plugin('mason.nvim'),
      },
    },
    config = function()
      require('oxygen.core.lsp')
    end,
    init = function()
      utils.lazy_load('nvim-lspconfig')

      utils.load_keymap('nvim-lspconfig')
    end,
    enabled = config.lsp.enabled,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oxygen.plugins.config.bufferline')
    end,
    init = function()
      utils.lazy_load('bufferline.nvim')

      utils.load_keymap('bufferline.nvim')
    end,
    enabled = not utils.disable_plugin('bufferline.nvim'),
  },

  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    config = function()
      require('oxygen.plugins.config.toggleterm')
    end,
    init = function()
      utils.load_keymap('toggleterm.nvim')
    end,
    enabled = not utils.disable_plugin('toggleterm.nvim'),
  },

  {
    'declancm/cinnamon.nvim',
    event = 'VeryLazy',
    config = function()
      require('oxygen.plugins.config.smooth-scrolling')
    end,
    enabled = not utils.disable_plugin('cinnamon.nvim'),
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTree', 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeClose' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oxygen.plugins.config.filemanager')
    end,
    init = function()
      utils.load_keymap('nvim-tree.lua')
    end,
    enabled = not utils.disable_plugin('nvim-tree.lua'),
  },

  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    enabled = cmp,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },

      {
        'windwp/nvim-autopairs',
        config = function()
          require('oxygen.plugins.config.other').autopairs()
        end,
      },
    },
    config = function()
      require('oxygen.plugins.config.cmp')
    end,
    enabled = cmp,
  },
}

if #config.plugins.add > 0 then
  table.insert(plugins, config.plugins.add)
end

return plugins
