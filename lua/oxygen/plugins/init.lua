return {
  {
    'folke/lazy.nvim',
    main = 'lazy',
    lazy = false,
    config = function()
      require('oxygen.base46').load_highlight('lazy')
    end,
  },
}
