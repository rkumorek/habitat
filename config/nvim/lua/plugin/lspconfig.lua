local lspconfig = require('lspconfig')
local utils = require('utils')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false, signs = false})

lspconfig.tsserver.setup({autostart = false})
lspconfig.rust_analyzer.setup({autostart = false})

-- Retrieves all diagnostics from all buffers and puts them into quickfix list.
local load_diagnostics_to_quickfix_list = function()
    vim.diagnostic.setqflist({
        severity = vim.diagnostic.severity.ERROR
    })
    vim.cmd('cwindow')
end

vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover)
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.references)
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<Leader>lp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>ln', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>lq', load_diagnostics_to_quickfix_list)
