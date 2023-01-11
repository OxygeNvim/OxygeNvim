-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    'vim',
    'config',
    'colors',
    'utils',
    'r',
    'commands',
    'ui',
  },
  read_globals = {
    'os',
    'vim',
  },
}

exclude_files = { 'lua/packer_compiled.lua' }

std = 'lua51+nvim'

self = false

cache = true

ignore = {
  '600',
}
