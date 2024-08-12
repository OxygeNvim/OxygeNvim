local utils = require('oxygen.core.utils')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not utils.filesystem.check_dir(lazypath) then
  utils.logger.log('Cloning lazy...')

  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })

  vim.opt.rtp:prepend(lazypath)

  if utils.r('lazy') then
    utils.logger.log('Lazy cloned successfully.')
  else
    utils.logger.error('Can\'t clone lazy\nLazy path: ' .. lazypath .. '\n')
  end
else
  vim.opt.rtp:prepend(lazypath)
end

local lazy = require('lazy')
lazy.setup({
  spec = {
    { import = 'oxygen.plugins' },
    { import = 'config.plugins' },
    string.find(utils.get_os(), 'android') and {
      import = 'oxygen.packs.os.android',
    } or {},
  },
  defaults = {
    opts = {},
    config = true,
    lazy = true,
    version = false,
  },
  ui = {
    border = config.ui.border,
  },
  install = {
    colorscheme = { 'base46' },
  },
  change_detection = {
    enabled = false,
  },
  dev = {
    path = '/mnt/code/oxygen/',
    fallback = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
})
