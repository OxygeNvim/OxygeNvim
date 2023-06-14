local api = vim.api

--- @param mod string
--- @return boolean
--- @return unknown
_G.r = function(mod)
  return pcall(require, mod)
end

utils.in_headless = #api.nvim_list_uis() == 0

utils.get_os = function()
  local os = vim.fn.system('uname')
  if os ~= 'Darwin' then
    os = vim.fn.system('uname -o')
  end

  return os
end

--- @param plugin_name string
utils.load_keymap = function(plugin_name)
  local keymaps = require('oxygen.core.keymaps')

  local set = function(mode, keybind, info)
    vim.keymap.set(mode, keybind, info[1], { desc = info[2] or nil, noremap = true, silent = true })
  end

  for mode, mode_values in pairs(keymaps[plugin_name]) do
    for keybind, info in pairs(mode_values) do
      set(mode, keybind, info)
    end
  end
end

--- @param package_name string
--- @return string
utils.get_mason_path = function(package_name)
  local mason_registry = require('mason-registry')
  local package = mason_registry.get_package(package_name)
  return package:get_install_path()
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
