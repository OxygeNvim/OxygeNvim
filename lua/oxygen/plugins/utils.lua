return {
  { 'nvim-lua/plenary.nvim' },

  {
    'famiu/bufdelete.nvim',
    init = function()
      utils.load_keymap('bufdelete.nvim')
    end,
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
  },

  {
    'numToStr/Comment.nvim',
    keys = { { 'gc', mode = { 'n', 'v' } }, { 'gb', mode = { 'n', 'v' } } },
    config = function(_, opts)
      require('Comment').setup(opts)
    end,
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
}
