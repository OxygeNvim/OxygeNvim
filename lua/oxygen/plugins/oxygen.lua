return {
  { 'OxygeNvim/packs', dev = true },

  {
    'OxygeNvim/base46',
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      require('oxygen.base46')
      base46.setup()
    end,
  },

  {
    'OxygeNvim/ui',
    dev = true,
    lazy = false,
    priority = 999,
    config = function()
      require('oxygen.ui')
      ui.setup()
    end,
  },

  {
    'OxygeNvim/extensions',
    event = 'VeryLazy',
    dev = true,
    config = function()
      require('oxygen.extensions')
      extensions.setup()
      require('oxygen.core.commands')
    end,
  },
}
