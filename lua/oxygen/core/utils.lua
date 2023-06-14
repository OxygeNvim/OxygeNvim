_G.utils = {
  logger = {},
  keymaps = {},
  filesystem = {},
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

--- @param type number
--- @param message string
--- @param write_log boolean
--- @param show_message boolean
utils.logger._log = function(type, message, write_log, show_message)
  if write_log then
    local file_name = vim.fn.stdpath('cache') .. '/oxygen/log'

    if not utils.filesystem.check_dir(vim.fn.stdpath('cache') .. '/oxygen') then
      utils.filesystem.create_dir(vim.fn.stdpath('cache') .. '/oxygen')
    end

    if not utils.filesystem.check_file(file_name) then
      utils.filesystem.create_file(file_name)
    end

    local content = utils.filesystem.get_file(file_name) .. '\n'

    local time = os.date('*t')
    time = time.hour .. ':' .. time.min .. ':' .. time.sec

    local type_str

    if type == vim.log.levels.INFO then
      type_str = 'INFO'
    elseif type == vim.log.levels.WARN then
      type_str = 'WARNING'
    elseif type == vim.log.levels.ERROR then
      type_str = 'ERROR'
    end

    content = content .. '[' .. time .. '][' .. type_str .. ']: ' .. message

    utils.filesystem.write_file(file_name, content)
  end

  if show_message then
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
end

--- @param file_name string
--- @param old_text string
--- @param new_text string
utils.replace_word = function(file_name, old_text, new_text)
  local content = utils.filesystem.get_file(file_name)
  local output = string.gsub(content, old_text, new_text)

  utils.filesystem.write_file(file_name, output)
end

--- @param package_name string
--- @return string
utils.get_mason_path = function(package_name)
  local mason_registry = require('mason-registry')
  local package = mason_registry.get_package(package_name)
  return package:get_install_path()
end

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.log = function(message, no_write_log, no_show_message)
  utils.logger._log(vim.log.levels.INFO, message, not no_write_log, not no_show_message)
end

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.warn = function(message, no_write_log, no_show_message)
  utils.logger._log(vim.log.levels.WARN, message, not no_write_log, not no_show_message)
end

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.error = function(message, no_write_log, no_show_message)
  utils.logger._log(vim.log.levels.ERROR, message, not no_write_log, not no_show_message)
end

--- @param file_name string
--- @return boolean
utils.filesystem.check_file = function(file_name)
  return vim.loop.fs_stat(file_name)
end

--- @param dir string
--- @return boolean
utils.filesystem.check_dir = function(dir)
  return vim.loop.fs_stat(dir)
end

--- @param dir string
--- @return boolean
utils.filesystem.create_dir = function(dir)
  vim.fn.mkdir(dir, 'p')

  return true
end

--- @param file_name string
--- @return boolean
utils.filesystem.create_file = function(file_name)
  local file = io.open(file_name, 'w')
  if file then
    file:write('')
    file:close()

    return true
  else
    utils.logger.error('Error while creating ' .. file_name, true)

    return false
  end
end

--- @param file_name string
--- @param content string
--- @return boolean
utils.filesystem.write_file = function(file_name, content)
  local file = io.open(file_name, 'w')
  if file then
    file:write(content)
    file:close()

    return true
  else
    utils.logger.error('Error while creating ' .. file_name, true)
    return false
  end
end

--- @param file_name string
--- @return string
utils.filesystem.get_file = function(file_name)
  local file = io.open(file_name, 'r')
  if file then
    local content = file:read('*a')
    file:close()

    return content
  else
    utils.logger.error('Error while reading ' .. file_name, true)

    return ''
  end
end

--- @param dir string
utils.filesystem.get_dir_contents = function(dir)
  return vim.fn.readdir(dir)
end

--- @param file_name string
--- @return boolean
utils.filesystem.remove_file = function(file_name)
  vim.fn.system('rm ' .. file_name)
  return true
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
