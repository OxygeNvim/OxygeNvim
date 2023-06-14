return utils.merge({
  defaults = {
    lazy = true,
    version = nil,
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
    path = '~/code/oxygen/',
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
}, config.plugins.add['lazy.nvim'] or {})
