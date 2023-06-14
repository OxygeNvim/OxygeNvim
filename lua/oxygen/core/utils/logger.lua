--- @param type number
--- @param message string
--- @param write_log boolean
--- @param show_message boolean
local log = function(type, message, write_log, show_message)
  if write_log then
    local file_name = vim.fn.stdpath('cache') .. '/oxygen/log'

    if not utils.filesystem.check_dir(vim.fn.stdpath('cache') .. '/oxygen') then
      utils.filesystem.create_dir(vim.fn.stdpath('cache') .. '/oxygen')
    end

    if not utils.filesystem.check_file(file_name) then
      utils.filesystem.create_file(file_name)
    end

    local content = utils.filesystem.get_file_contents(file_name) .. '\n'

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

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.log = function(message, no_write_log, no_show_message)
  log(vim.log.levels.INFO, message, not no_write_log, not no_show_message)
end

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.warn = function(message, no_write_log, no_show_message)
  log(vim.log.levels.WARN, message, not no_write_log, not no_show_message)
end

--- @param message string
--- @param no_write_log? boolean
--- @param no_show_message? boolean
utils.logger.error = function(message, no_write_log, no_show_message)
  log(vim.log.levels.ERROR, message, not no_write_log, not no_show_message)
end
