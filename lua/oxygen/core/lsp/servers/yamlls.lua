local M = {}

M.settings = {
  yaml = {
    schemas = require('schemastore').yaml.schemas(),
  },
}

return M
