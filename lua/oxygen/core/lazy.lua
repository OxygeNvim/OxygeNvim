local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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

  if r('lazy') then
    utils.logger.log('Lazy cloned successfully.')
  else
    utils.logger.error('Can\'t clone lazy\nLazy path: ' .. lazypath .. '\n')
  end
else
  vim.opt.rtp:prepend(lazypath)
end

local lazy = require('lazy')
lazy.setup('oxygen.plugins', require('oxygen.plugins.config.lazy'))
