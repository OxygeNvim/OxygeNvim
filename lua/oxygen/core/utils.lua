_G.utils = {
  logger = {},
  keymaps = {},
}

local api = vim.api

--- @param mod string
--- @return boolean
--- @return unknown
_G.r = function(mod)
  return pcall(require, mod)
end

utils.in_headless = #api.nvim_list_uis() == 0

--- @param plugin_name string
utils.load_keymap = function(plugin_name)
  local keymaps = require('oxygen.core.keymaps')

  local set = function(mode, keybind, info)
    vim.keymap.set(mode, keybind, info[1], { desc = info[2] or nil, noremap = true, silent = true })
  end

  for mode, mode_values in pairs(keymaps[plugin_name]) do
    for keybind, info in pairs(mode_values) do
      if plugin_name ~= 'main' then
        if not utils.disable_plugin(plugin_name) then
          set(mode, keybind, info)
        end
      else
        set(mode, keybind, info)
      end
    end
  end
end

--- @param ... table
--- @return table
utils.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

--- @param plugin string
--- @return boolean
utils.disable_plugin = function(plugin)
  local check = function(name)
    return vim.tbl_contains(config.plugins.remove, name)
  end

  if config.plugins.remove then
    if plugin and check(plugin) then
      return true
    end
  end

  return false
end

utils.logger._log = function(type, message)
  if not utils.in_headless then
    vim.notify(message, type)
  else
    if type == vim.log.levels.ERROR then
      error(message .. '\n')
    else
      print(message .. '\n')
    end
  end
end

--- @param message string
utils.logger.log = function(message)
  utils.logger._log(vim.log.levels.INFO, message)
end

--- @param message string
utils.logger.warn = function(message)
  utils.logger._log(vim.log.levels.WARN, message)
end

--- @param message string
utils.logger.error = function(message)
  utils.logger._log(vim.log.levels.ERROR, message)
end

--- @param plugin string
utils.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('BeLazyOnFileOpen' .. plugin, {}),
    callback = function()
      local file = vim.fn.expand('%')
      local condition = file ~= 'NvimTree_1' and file ~= '[lazy]' and file ~= ''

      if condition then
        if plugin ~= 'nvim-treesitter' then
          vim.defer_fn(function()
            require('lazy').load({ plugins = plugin })

            if plugin == 'nvim-lspconfig' then
              vim.cmd('silent! do FileType')
            end
          end, 0)
        else
          require('lazy').load({ plugins = plugin })
        end
      end
    end,
  })
end

return utils
