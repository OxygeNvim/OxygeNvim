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
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    },
    config = function(_, opts)
      require('luasnip').config.set_config(opts)
    end,
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

      local atom_styled = config.ui.cmp.style == 'atom' or config.ui.cmp.style == 'atom_colored'

      return {
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
            border = atom_styled and 'none' or config.ui.border,
            winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder',
          },
          completion = {
            border = atom_styled and 'none' or config.ui.border,
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,FloatBorder:CmpBorder,Search:None',
            scrollbar = false,
            side_padding = atom_styled and 0 or 1,
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
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        formatting = {
          fields = atom_styled and { 'kind', 'abbr', 'menu' } or { 'abbr', 'kind', 'menu' },
          format = function(_, item)
            item.abbr = item.abbr .. ' '
            item.menu = config.ui.cmp.kind_text and item.kind or ''
            item.menu_hl_group = atom_styled and 'LineNr' or 'CmpItemKind' .. item.kind
            item.kind = icons.kind_icons[item.kind] .. ' '

            if atom_styled then
              item.kind = ' ' .. item.kind
            end

            return item
          end,
        },
        sources = {
          { name = 'nvim_lsp', priority = 1500 },
          { name = 'buffer', keyword_length = 2, priority = 750 },
          { name = 'path', keyword_length = 2, priority = 500 },
          { name = 'luasnip', keyword_length = 2, priority = 250 },
        },
      }
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
