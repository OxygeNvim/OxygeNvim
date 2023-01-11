local M = {}

local schemastore = require('schemastore')

M.settings = {
  json = {
    schemas = schemastore.json.schemas(),
    validate = { enable = true },
  },
}

return M
