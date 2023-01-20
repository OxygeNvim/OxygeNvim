local defaults = require('core.lsp.defaults')
local null_ls = require('null-ls')

local has_eslint_config = function(u)
  return u.root_has_file('.eslintrc') or u.root_has_file('.eslintrc.json') or u.root_has_file('.eslintrc.js')
end

local has_exec = function(exec)
  if vim.fn.executable(exec) == 1 then
    return true
  else
    return false
  end
end

null_ls.setup(utils.merge({
  sources = {
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.code_actions.eslint_d.with({
      condition = has_eslint_config,
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = has_eslint_config,
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.formatting.prettierd.with({
      condition = function()
        return has_exec('prettierd')
      end,
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. '/.prettierrc',
      },
    }),
    null_ls.builtins.formatting.shfmt.with({
      condition = function()
        return has_exec('shfmt')
      end,
    }),
    null_ls.builtins.formatting.stylua.with({
      condition = function()
        return has_exec('stylua')
      end,
    }),
    null_ls.builtins.formatting.black.with({
      condition = function()
        return has_exec('black')
      end,
    }),
  },
}, defaults, config.lsp.null_ls or {}))
