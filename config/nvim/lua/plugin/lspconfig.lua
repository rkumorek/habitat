local lspconfig = require('lspconfig')

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 { underline = true, virtual_text = false, signs = false })

-- Retrieves all diagnostics from all buffers and puts them into quickfix list.
local load_diagnostics_to_quickfix_list = function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    vim.cmd('cwindow')
end

-- :help lspconfig-keybindings
function on_attach(client, bufnr)
    local opt = { buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opt)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opt)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt)
    vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.references, opt)
    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opt)
    vim.keymap.set('n', '<Leader>lp', vim.diagnostic.goto_prev, opt)
    vim.keymap.set('n', '<Leader>ln', vim.diagnostic.goto_next, opt)
    vim.keymap.set('n', '<Leader>lq', load_diagnostics_to_quickfix_list, opt)
    vim.keymap.set('n', '<Leader>l=', vim.lsp.buf.format, opt)
    vim.keymap.set('n', '<Leader>lc', vim.lsp.buf.code_action, opt)
end

lspconfig.tsserver.setup({ autostart = false, on_attach = on_attach })
lspconfig.rust_analyzer.setup({ autostart = false, on_attach = on_attach })
lspconfig.clangd.setup({ autostart = false, on_attach = on_attach })
