return {
  {
    'windwp/nvim-ts-autotag',
    main = 'nvim-ts-autotag',
    event = { 'InsertEnter' },
    opts = {
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = false,
      },
    },
  },

  {
    'windwp/nvim-autopairs',
    main = 'nvim-autopairs',
    event = { 'InsertEnter' },
    opts = {
      check_ts = true,
      fast_wrap = {
        chars = { '{', '[', '(', '"', '\'', '`' },
        offset = 0,
        check_comma = true,
      },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)
      require('cmp').event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } })
      )
    end,
  },

  {
    'fedepujol/move.nvim',
    main = 'move',
    cmd = {
      'MoveLine',
      'MoveWord',
      'MoveBlock',
    },
    keys = {
      { '<A-j>', ':MoveLine(1)<CR>', desc = 'Move current line to top' },
      { '<A-k>', ':MoveLine(-1)<CR>', desc = 'Move current line to bottom' },
      { '<A-j>', ':MoveBlock(1)<CR>', mode = 'v', desc = 'Move selected bock to top' },
      { '<A-k>', ':MoveBlock(-1)<CR>', mode = 'v', desc = 'Move selected block to bottom' },
    },
    opts = {
      line = {
        enable = true,
        indent = true,
      },
      block = {
        enable = true,
        indent = true,
      },
      word = {
        enable = true,
      },
    },
  },
}
