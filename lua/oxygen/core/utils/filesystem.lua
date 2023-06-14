--- @param file_name string
--- @param old_text string
--- @param new_text string
utils.replace_word = function(file_name, old_text, new_text)
  local content = utils.filesystem.get_file_contents(file_name)
  local output = string.gsub(content, old_text, new_text)

  utils.filesystem.write_file(file_name, output)
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
utils.filesystem.get_file_contents = function(file_name)
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
