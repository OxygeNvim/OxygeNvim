return {
  {
    'L3MON4D3/LuaSnip',
    build = (function()
      if vim.fn.executable('make') == 0 then
        return
      end

      return 'make install_jsregexp'
    end)(),
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
    main = 'cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local icons = require('oxygen.ui.icons')

      return table.merge({
        preselect = cmp.PreselectMode.Item,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        window = {
          documentation = {
            border = config.ui.border,
            winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder',
          },
          completion = {
            border = config.ui.border,
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,FloatBorder:CmpBorder,Search:None',
            scrollbar = false,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<ESC>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
              require('luasnip').expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
              require('luasnip').jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        formatting = {
          fields = { 'kind', 'abbr' },
          format = function(_, vim_item)
            vim_item.kind = ' ' .. icons.kind_icons[vim_item.kind] .. ' '

            return vim_item
          end,
        },
        sources = {
          { name = 'nvim_lsp', priority = 1500 },
          { name = 'buffer',   keyword_length = 2, priority = 750 },
          { name = 'path',     keyword_length = 2, priority = 500 },
          { name = 'luasnip',  keyword_length = 2, priority = 250 },
        },
      }, config.ui.cmp_style == 'atom' and {
        window = {
          completion = {
            border = 'none',
            col_offset = -3,
            side_padding = 0,
          },
          documentation = {
            border = 'none',
          },
        },
      } or {})
    end,
    config = function(_, opts)
      require('oxygen.base46').load_highlight('cmp')

      local cmp = require('cmp')
      cmp.setup(opts)

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
