local defaults = require('oxygen.core.lsp.defaults')
local null_ls = require('null-ls')

local has_eslint_config = function(u)
  return u.root_has_file('.eslintrc') or u.root_has_file('.eslintrc.json') or u.root_has_file('.eslintrc.js')
end

local sources = {
  null_ls.builtins.formatting.prettierd.with({
    env = {
      PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. '/.prettierrc',
    },
  }),
  null_ls.builtins.code_actions.eslint_d.with({
    condition = has_eslint_config,
    prefer_local = 'node_modules/.bin',
  }),
  null_ls.builtins.diagnostics.eslint_d.with({
    condition = has_eslint_config,
    prefer_local = 'node_modules/.bin',
  }),
  null_ls.builtins.formatting.clang_format,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.black,
}

null_ls.setup(utils.merge({
  sources = sources,
}, defaults, config.plugins.add['null-ls.nvim'] or {}))
