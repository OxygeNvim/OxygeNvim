local M = {}

M['main'] = {
  i = {
    ['<CS-d>'] = { '<C-o>:normal!"-Y"-p<CR>' },
    ['<C-g><C-w>'] = { '<C-o>vgw' },
    ['<C-J>'] = { '<C-o>J' },
  },
  n = {
    ['<ESC>'] = { ':noh<CR>' },
    ['<C-s>'] = { ':w<CR>', 'Save file' },
    ['<C-Up>'] = { ':resize +2<CR>' },
    ['<C-Down>'] = { ':resize -2<CR>' },
    ['<C-Left>'] = { ':vertical resize -2<CR>' },
    ['<C-Right>'] = { ':vertical resize +2<CR>' },
  },
  v = {
    ['p'] = { 'p:let @+=@0<CR>' },
  },
}

M['nvim-tree.lua'] = {
  n = {
    ['<C-n>'] = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
    ['<leader>nf'] = { ':NvimTreeFocus<CR>', 'Focus NvimTree' },
  },
}

M['bufferline.nvim'] = {
  n = {
    ['<TAB>'] = { ':BufferLineCycleNext<CR>', 'Next Buffer' },
    ['<S-TAB>'] = { ':BufferLineCyclePrev<CR>', 'Previous Buffer' },
    ['<leader>bn'] = { ':BufferLineCycleNext<CR>', 'Next Buffer' },
    ['<leader>bp'] = { ':BufferLineCyclePrev<CR>', 'Previous Buffer' },
  },
}

M['telescope.nvim'] = {
  n = {
    ['<leader>tt'] = { ':Telescope<CR>', 'Telescope' },
    ['<leader>tf'] = { ':Telescope find_files<CR>', 'Find files' },
    ['<leader>tc'] = { ':Telescope git_commits<CR>', 'Git commits' },
    ['<leader>ts'] = { ':Telescope git_status<CR>', 'Git status' },
  },
}

M['toggleterm.nvim'] = {
  n = {
    ['<leader>qt'] = { ':ToggleTerm<CR>', 'ToggleTerm' },
  },
}

M['nvim-lspconfig'] = {
  n = {
    ['<leader>gD'] = {
      function()
        vim.lsp.buf.declaration()
      end,
      'LSP declaration',
    },
    ['<leader>gd'] = {
      function()
        vim.lsp.buf.definition()
      end,
      'LSP definition',
    },
    ['<leader>gi'] = {
      function()
        vim.lsp.buf.implementation()
      end,
      'LSP implementation',
    },
    ['<leader>gh'] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      'LSP signature_help',
    },
    ['<leader>gt'] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      'LSP definition type',
    },
    ['<leader>rn'] = {
      function()
        ui.lsp.rename_popup()
      end,
      'LSP rename',
    },
    ['<leader>ga'] = {
      function()
        vim.lsp.buf.code_action()
      end,
      'LSP code_action',
    },
    ['<leader>gr'] = {
      function()
        vim.lsp.buf.references()
      end,
      'LSP references',
    },
    ['<leader>dp'] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      'Previous diagnostic',
    },
    ['<leader>dn'] = {
      function()
        vim.diagnostic.goto_next()
      end,
      'Next diagnostic',
    },
  },
}

M['aerial.nvim'] = {
  n = {
    ['<leader>aa'] = { ':AerialToggle<CR>', 'Toggle Aerial' },
  },
}

M['bufdelete.nvim'] = {
  n = {
    ['<leader>x'] = {
      function()
        require('bufdelete').bufdelete(0, true)
      end,
      'Close current buffer',
    },
  },
}

M['move.nvim'] = {
  n = {
    ['<A-j>'] = { ':MoveLine(1)<CR>', 'Move current line to bottom' },
    ['<A-k>'] = { ':MoveLine(-1)<CR>', 'Move current line to top' },
  },
  v = {
    ['<A-j>'] = { ':MoveBlock(1)<CR>', 'Move a block to bottom' },
    ['<A-k>'] = { ':MoveBlock(-1)<CR>', 'Move a block to top' },
  },
}

if config.keymaps.custom then
  M.main = utils.merge(M.main, config.keymaps.custom)
end

vim.g.mapleader = config.keymaps.leader

return M
