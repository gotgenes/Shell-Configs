local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Commands.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagShow lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspWorkspaceList lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
  vim.cmd("command! LspWorkspaceAdd lua vim.lsp.buf.add_workspace_folder()")
  vim.cmd("command! LspWorkspaceRemove lua vim.lsp.buf.remove_workspace_folder()")

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>LspDeclaration<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>LspHover<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>LspSignatureHelp<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>LspTypeDef<CR>', opts)
  buf_set_keymap('n', '<leader>cr', '<cmd>LspRename<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>LspDiagPrev<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>LspDiagNext<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>LspFormatting<CR>', opts)
  -- Provided by Telescope
  buf_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
  -- Provided by Trouble
  buf_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', opts)
  buf_set_keymap('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>', opts)
  buf_set_keymap('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>', opts)
  buf_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', opts)
  buf_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', opts)
  buf_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', opts)
end

local on_attach_no_format = function(client, buffnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  on_attach(client, buffnr)
end

nvim_lsp.pyright.setup {
  on_attach = on_attach_no_format,
}

nvim_lsp.tsserver.setup {
  on_attach = function(client, buffnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {
      enable_formatting = true
    }
    on_attach_no_format(client, buffnr)
    ts_utils.setup_client(client)
  end
}

local servers = { "null-ls", "vimls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end


nvim_lsp.gopls.setup {
  cmd = { "gopls", "-remote=auto" },
  on_attach = on_attach,
}

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
