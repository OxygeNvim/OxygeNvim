--- @param ... table
--- @return table
utils.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

--- @param ... table
--- @return table
utils.extend = function(...)
  return vim.list_extend(...)
end

--- @param table table
--- @return string
utils.print_table = function(table)
  if type(table) == 'table' then
    local s = '{ '
    for k, v in pairs(table) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. utils.print_table(v) .. ','
    end
    return s .. '} '
  else
    return tostring(table)
  end
end
