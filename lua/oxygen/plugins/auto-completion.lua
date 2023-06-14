return {
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
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)
          require('cmp').event:on(
            'confirm_done',
            require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } })
          )
        end,
        opts = {
          check_ts = true,
          ts_config = { java = false },
          fast_wrap = {
            chars = { '{', '[', '(', '"', '\'', '`' },
            offset = 0,
            check_comma = true,
          },
        },
      },
    },
    config = function(_, opts)
      base46.load_highlight('cmp')

      require('cmp').setup(opts)
    end,
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      return utils.merge({
        preselect = cmp.PreselectMode.Item,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          documentation = {
            winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder',
          },
          completion = {
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,FloatBorder:CmpBorder,Search:None',
            scrollbar = false,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {
            'i',
            's',
          }),
        }),
        formatting = {
          fields = { 'kind', 'abbr' },
          format = function(_, vim_item)
            vim_item.kind = ' ' .. ui.icons.kind_icons[vim_item.kind] .. ' '

            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', keyword_length = 2, priority = 750 },
          { name = 'buffer', keyword_length = 2, priority = 500 },
          { name = 'path', keyword_length = 2, priority = 250 },
        }),
      }, config.ui.cmp_style == 'atom' and {
        window = {
          completion = {
            col_offset = -3,
            side_padding = 0,
          },
        },
      } or {})
    end,
  },
}
