local lspconfig = require('lspconfig')
local utils = require('utils')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false, signs = false})

lspconfig.tsserver.setup({autostart = false})
lspconfig.rust_analyzer.setup({autostart = false})

-- Retrieves all diagnostics from the current buffer
-- and puts them into quickfix list.
local load_diagnostics_to_quickfix_list = function()
    local locations = {}
    local empty = true

    for bufnr, diagnostics in pairs(vim.diagnostic.get()) do
        for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity == 1 then
                if empty == true then empty = false end

                table.insert(locations, {
                    bufnr = bufnr,
                    lnum = diagnostic.range.start.line + 1,
                    col = diagnostic.range.start.character + 1,
                    text = diagnostic.message
                })
            end
        end
    end

    vim.diagnostic.setqflist(locations)
    vim.cmd('cwindow')
end

vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover)
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.references)
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<Leader>l[', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>l]', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>lq', load_diagnostics_to_quickfix_list)
