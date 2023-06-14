-- vim: ft=lua

stds.nvim = {
  globals = {
    'vim',
    'utils',
    'base46',
    'config',
    'ui',
    'r',
  },
  read_globals = {
    'os',
    'vim',
  },
}

std = 'lua51+nvim'

self = false

cache = true

ignore = {
  '600',
}
