local cmp = not utils.disable_plugin('nvim-cmp')

local plugins = {
  { 'folke/lazy.nvim' },

  {
    'OxygeNvim/base46',
    lazy = false,
    priority = 1000,
    config = function()
      local base46 = require('base46')

      base46.setup({
        custom_highlights = config.ui.custom_highlights or {},
        transparency = config.ui.transparency or false,
        theme = config.ui.theme or 'rosepine',
        load_all_highlights = false,
      })

      require('core.ui')

      vim.opt.statusline = '%!v:lua.require(\'core.ui.statusline\').run()'
    end,
  },

  { 'nvim-lua/plenary.nvim' },
  { 'MunifTanjim/nui.nvim' },

  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.config.other').devicons()
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
      require('plugins.config.other').editorconfig()
    end,
    enabled = not utils.disable_plugin('editorconfig.nvim'),
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.config.other').which_key()
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
      require('plugins.config.other').aerial()
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
      require('plugins.config.other').colorizer()
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
      require('plugins.config.telescope')
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
      require('plugins.config.indent-blankline')
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
      require('plugins.config.treesitter')
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
      require('plugins.config.other').gitsigns()
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
      require('plugins.config.other').comment()
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
      require('plugins.config.todo-comments')
    end,
    enabled = not utils.disable_plugin('todo-comments.nvim'),
  },

  { 'b0o/SchemaStore.nvim', ft = 'json', enabled = config.lsp.enabled },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('core.lsp.servers.null_ls')
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
          require('plugins.config.mason')
        end,
        enabled = not utils.disable_plugin('mason.nvim'),
      },
    },
    config = function()
      require('core.lsp')
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
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.config.bufferline')
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
      require('plugins.config.toggleterm')
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
      require('plugins.config.smooth-scrolling')
    end,
    enabled = not utils.disable_plugin('cinnamon.nvim'),
  },

  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTree', 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeClose' },
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.config.filemanager')
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
    },
    enabled = cmp,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },

      {
        'windwp/nvim-autopairs',
        config = function()
          require('plugins.config.other').autopairs()
        end,
      },
    },
    config = function()
      require('plugins.config.cmp')
    end,
    enabled = cmp,
  },
}

local userPlugins = config.plugins.add
if userPlugins then
  if type(userPlugins) == 'table' then
    table.insert(plugins, userPlugins)
  else
    utils.logger.warn('Expected table but got "' .. type(userPlugins) .. '" in user plugin\'s!')
  end
end

return plugins
