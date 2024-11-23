local M = {
  filesystem = {},
  logger = {},
  buffer = {},
}

local api = vim.api

--- @param modname string
---
--- @return boolean, unknown
M.r = function(modname)
  return pcall(require, modname)
end

--- @type boolean
M.in_headless = #api.nvim_list_uis() == 0

--- @return string
M.get_os = function()
  local os = string.lower(vim.fn.system('uname'))
  if os ~= 'darwin' then
    os = string.lower(vim.fn.system('uname -o'))
  end

  return os
end

--- @param package_name string
---
--- @return string
M.get_mason_path = function(package_name)
  local mason_registry = require('mason-registry')
  local package = mason_registry.get_package(package_name)
  return package:get_install_path()
end

--- @param plugin_name string
M.lazy_load = function(plugin_name)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
    group = M.create_augroup('LazyOnFileOpen' .. plugin_name),
    callback = function()
      local file = vim.fn.expand('%')
      local condition = file ~= 'NvimTree_1' and file ~= '[lazy]' and file ~= ''

      if condition then
        if plugin_name ~= 'nvim-treesitter' then
          vim.defer_fn(function()
            require('lazy').load({ plugins = { plugin_name } })

            if plugin_name == 'nvim-lspconfig' then
              vim.cmd('silent! do FileType')
            end
          end, 0)
        else
          require('lazy').load({ plugins = { plugin_name } })
        end
      end
    end,
  })
end

--- @param file_name string
---
--- @return boolean
M.filesystem.check_file = function(file_name)
  return vim.uv.fs_stat(file_name)
end

--- @param directory string
---
--- @return boolean
M.filesystem.check_dir = function(directory)
  return vim.uv.fs_stat(directory)
end

--- @param directory string
---
--- @return boolean
M.filesystem.create_dir = function(directory)
  vim.fn.mkdir(directory, 'p')

  if not M.filesystem.check_dir(directory) then
    M.logger.error('Failed to create ' .. directory)

    return false
  end

  return true
end

--- @param file_name string
--- @param content string
---
--- @return boolean
M.filesystem.write_file = function(file_name, content)
  local file, error_message = io.open(file_name, 'w')
  if file then
    file:write(content)
    file:close()

    if not M.filesystem.check_file(file_name) then
      M.logger.error('Failed to create ' .. file_name)

      return false
    end

    return true
  else
    M.logger.error('Error while writing to ' .. file_name)
    M.logger.error(error_message)

    return false
  end
end

--- @param file_name string
---
--- @return string
M.filesystem.get_file_contents = function(file_name)
  if not M.filesystem.check_file(file_name) then
    M.logger.error(file_name .. ' doesn\'t exist')

    return ''
  end

  local file, error_message = io.open(file_name, 'r')
  if file then
    local content = file:read('*a')
    file:close()

    return content
  else
    M.logger.error('Error while reading ' .. file_name)
    M.logger.error(error_message)

    return ''
  end
end

--- @param dir string
---
--- @return table<string>
M.filesystem.get_dir_contents = function(dir)
  return vim.fn.readdir(dir)
end

--- @param file_name string
---
--- @return boolean
M.filesystem.remove_file = function(file_name)
  vim.fn.system('rm ' .. file_name)

  if M.filesystem.check_file(file_name) then
    M.logger.error('Failed to remove ' .. file_name)

    return false
  end

  return true
end

--- @param file_name string
--- @param old string
--- @param new string
---
--- @return boolean
M.filesystem.replace_string = function(file_name, old, new)
  local content = M.filesystem.get_file_contents(file_name)
  local output, number_of_replacements = string.gsub(content, old, new)

  M.filesystem.write_file(file_name, output)

  if number_of_replacements == 0 then
    M.logger.error('Found 0 text occurences')

    return false
  elseif M.filesystem.get_file_contents(file_name) == content then
    M.logger.error('Failed to replace text at ' .. file_name)

    return false
  elseif M.filesystem.get_file_contents(file_name) == output then
    return true
  end
end

--- @param ... table
---
--- @return table
table.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

--- @param ... table
---
--- @return table
table.extend = function(...)
  return vim.list_extend(...)
end

--- @param tbl table
--- @param value string
---
--- @return table
table.remove_by_value = function(tbl, value)
  for index, table_value in pairs(tbl) do
    if value == table_value then
      tbl[index] = nil
    end
  end

  return tbl
end

--- @param tbl table
--- @param value any
---
--- @return number|nil
table.indexOf = function(tbl, value)
  for index, table_value in pairs(tbl) do
    if value == table_value then
      return index
    end
  end

  return nil
end

--- @param tbl table
--- @param value string
---
--- @return boolean
table.has = function(tbl, value)
  return table.indexOf(tbl, value) ~= nil
end

--- @param level number
--- @param message string
--- @param write_log? boolean
--- @param show_message? boolean
local log = function(level, message, write_log, show_message)
  if show_message == nil then
    show_message = true
  end

  if write_log == nil then
    write_log = true
  end

  if write_log then
    local oxygen_cache = vim.fn.stdpath('cache') .. '/oxygen'
    local log_file = oxygen_cache .. '/log'

    if not M.filesystem.check_dir(oxygen_cache) then
      M.filesystem.create_dir(oxygen_cache)
    end

    if not M.filesystem.check_file(log_file) then
      M.filesystem.write_file(log_file, '')
    end

    local content = M.filesystem.get_file_contents(log_file)

    local time = os.date('*t')
    time = time.hour .. ':' .. time.min .. ':' .. time.sec

    local type_str

    if level == vim.log.levels.INFO then
      type_str = 'INFO'
    elseif level == vim.log.levels.WARN then
      type_str = 'WARNING'
    elseif level == vim.log.levels.ERROR then
      type_str = 'ERROR'
    end

    content = content .. '[' .. time .. '][' .. type_str .. ']: ' .. message .. '\n'

    M.filesystem.write_file(log_file, content)
  end

  if show_message then
    if not M.in_headless then
      vim.notify(message, level, { title = 'OxygeNvim' })
    else
      if level == vim.log.levels.ERROR then
        error(message .. '\n')
      else
        print(message .. '\n')
      end
    end
  end
end

--- @param message string
--- @param write_log? boolean
--- @param show_message? boolean
M.logger.log = function(message, write_log, show_message)
  log(vim.log.levels.INFO, message, write_log, show_message)
end

--- @param message string
--- @param write_log? boolean
--- @param show_message? boolean
M.logger.warn = function(message, write_log, show_message)
  log(vim.log.levels.WARN, message, write_log, show_message)
end

--- @param message string
--- @param write_log? boolean
--- @param show_message? boolean
M.logger.error = function(message, write_log, show_message)
  log(vim.log.levels.ERROR, message, write_log, show_message)
end

--- @param bufnr? number
---
--- @return boolean
M.buffer.is_buffer_valid = function(bufnr)
  return bufnr and (api.nvim_buf_is_valid(bufnr) and api.nvim_get_option_value('buflisted', {
    buf = bufnr,
  })) or false
end

--- @param bufnr? number
---
--- @return boolean
M.buffer.is_modified = function(bufnr)
  return bufnr and api.nvim_get_option_value('modified', {
    buf = bufnr,
  }) or false
end

--- @param bufnr? number
---
--- @return boolean
M.buffer.is_readonly = function(bufnr)
  return bufnr and api.nvim_get_option_value('readonly', {
    buf = bufnr,
  }) or false
end

--- @param name string
--- @param opts? table
---
--- @return unknown
M.create_augroup = function(name, opts)
  return vim.api.nvim_create_augroup('OxygeNvim' .. name, opts or { clear = true })
end

return M
