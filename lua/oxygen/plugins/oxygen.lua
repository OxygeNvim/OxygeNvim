return {
  {
    'OxygeNvim/base46',
    dev = config.dev,
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'OxygeNvim/ui',
    dev = config.dev,
    lazy = false,
    opts = {},
  },

  {
    'OxygeNvim/extensions',
    dev = config.dev,
    event = { 'VeryLazy' },
    config = function()
      require('oxygen.extensions').setup()

      require('telescope').load_extension('theme_switcher')
    end,
  },

  { 'OxygeNvim/packs', dev = config.dev },
}
