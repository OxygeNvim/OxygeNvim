local opt = vim.opt

opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldsep = ' ',
  foldopen = '',
  foldclose = '',
}

opt.shortmess:append('mnrwxcsWTI')

opt.listchars = { tab = '··', trail = '·', lead = '·' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.inccommand = 'split'
opt.encoding = 'utf-8'
opt.filetype = 'unix'
opt.foldcolumn = '1'
opt.mouse = 'a'

opt.termguicolors = true
opt.smoothscroll = true
opt.smartindent = true
opt.splitbelow = true
opt.cursorline = true
opt.splitright = true
opt.foldenable = true
opt.lazyredraw = true
opt.ignorecase = true
opt.cursorline = true
opt.smartcase = true
opt.expandtab = true
opt.hlsearch = true
opt.autoread = true
opt.undofile = true
opt.number = true
opt.hidden = true
opt.list = true

opt.writebackup = false
opt.showmode = false
opt.backup = false
opt.ruler = false
opt.wrap = false

opt.foldlevelstart = 100
opt.sidescrolloff = 8
opt.timeoutlen = 250
opt.updatetime = 100
opt.numberwidth = 2
opt.softtabstop = 2
opt.foldlevel = 100
opt.laststatus = 3
opt.shiftwidth = 2
opt.scrolloff = 4
opt.tabstop = 2

if vim.g.neovide then
  local g = vim.g

  g.neovide_padding_top = 2
  g.neovide_padding_bottom = 2
  g.neovide_padding_right = 2
  g.neovide_padding_left = 2

  g.neovide_floating_shadow = false

  opt.linespace = 10
end

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'

vim.cmd('filetype on')
