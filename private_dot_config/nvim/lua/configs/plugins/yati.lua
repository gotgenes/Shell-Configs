local M = {}

local ts_configs = require('nvim-treesitter.configs')

function M.setup()
  ts_configs.setup({
    indent = {
      enable = false,
    },
    yati = {
      enable = true,
      default_fallback = function(lnum, computed, bufnr)
        return require('tmindent').get_indent(lnum, bufnr) + computed
      end,
    },
  })
end

return M