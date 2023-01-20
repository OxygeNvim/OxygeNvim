local cmp = require('cmp')

require('base46').load_highlight('cmp')

cmp.setup(utils.merge({
  preselect = cmp.PreselectMode.Item,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
      local luasnip = require('luasnip')

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
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path', keyword_length = 2 },
    { name = 'buffer', keyword_length = 2 },
    { name = 'vsnip', keyword_length = 2 },
  }),
  experimental = {
    ghost_text = {},
  },
}, config.plugins.config['nvim-cmp'] or {}))
