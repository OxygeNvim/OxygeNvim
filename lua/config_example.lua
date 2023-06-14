local M = {}

M.keymaps = {
  leader = ' ',
  custom = {
    -- mode of keymap (i, n, v, t)
    n = {
      -- 1. The keybinding
      -- 2. The command
      -- 3. Description (optional)
      ['<C-n>'] = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
    },
  },
}

M.ui = {
  theme = 'rosepine',
  border = 'rounded', -- rounded, single, double
  cmp_style = 'atom', -- default, atom, bordered
  statusline = {
    separator_style = 'default', -- default | round | block | arrow
  },
}

M.plugins = {
  add = {
    -- { 'foo/bar' }
  },
  remove = {
    -- 'foobar.nvim'
  },
  config = {},
}

M.lsp = {
  enabled = true,
  format_on_save = true,
  -- Default servers
  servers = {
    clangd = {
      -- use local clangd instead of installing it from mason
      install = false,
    }, -- C, C++
    lua_ls = {
      config = {
        -- lsp configuration options comes here
      },
    }, -- Lua
    rust_analyzer = {}, -- Rust
    jedi_language_server = {}, -- Python
    tsserver = {}, -- JavaCcript, TypeScript
    jsonls = {}, -- Json
    bashls = {}, -- Sh, Bash
    cssls = {}, -- CSS
    vuels = {}, -- Vue
    html = {}, -- HTML
  },
}

return M
