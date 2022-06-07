local M = {}

local scrollbar = require('scrollbar')
local scrollbar_search = require('scrollbar.handlers.search')
local wk = require('which-key')

local function set_keymaps()
  wk.register({
    ['*'] = { [[*<Cmd>lua require('hlslens').start()<CR>]], '* search' },
    ['#'] = { [[#<Cmd>lua require('hlslens').start()<CR>]], '# search' },
    ['g*'] = { [[g*<Cmd>lua require('hlslens').start()<CR>]], 'g* search' },
    ['g#'] = { [[g#<Cmd>lua require('hlslens').start()<CR>]], 'g# search' },
  }, {})
end

function M.setup()
  scrollbar.setup()
  scrollbar_search.setup()
  set_keymaps()
end

return M