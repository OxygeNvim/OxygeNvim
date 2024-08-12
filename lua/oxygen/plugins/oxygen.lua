return {
  {
    'OxygeNvim/base46',
    main = 'oxygen.base46',
    dev = config.dev,
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'OxygeNvim/ui',
    main = 'oxygen.ui',
    dev = config.dev,
    lazy = false,
    opts = {},
  },

  {
    'OxygeNvim/extensions',
    main = 'oxygen.extensions',
    dev = config.dev,
    event = { 'VeryLazy' },
    config = function()
      require('oxygen.extensions').setup()

      require('telescope').load_extension('theme_switcher')
    end,
  },

  { 'OxygeNvim/packs', dev = true },
}
