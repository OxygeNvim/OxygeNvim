local opt = vim.opt
local g = vim.g

opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.clipboard = { 'unnamed', 'unnamedplus' }
opt.fillchars = { eob = ' ' }
opt.listchars = { tab = '··', trail = '·', lead = '·' }
opt.encoding = 'utf-8'
opt.mouse = 'a'

opt.number = true
opt.cursorline = true
opt.list = true
opt.smartindent = true
opt.termguicolors = true
opt.lazyredraw = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.hidden = true
opt.autoread = true
opt.expandtab = true
opt.splitbelow = true
opt.splitright = true

opt.writebackup = false
opt.showmode = false
opt.backup = false
opt.ruler = false
opt.wrap = false

opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.softtabstop = 2
opt.laststatus = 3
opt.shiftwidth = 2
opt.scrolloff = 8
opt.numberwidth = 2
opt.sidescrolloff = 8
opt.tabstop = 2

opt.shortmess:append('csTI')

g.mapleader = config.keymaps.leader
