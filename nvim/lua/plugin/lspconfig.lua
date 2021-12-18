local lspconfig = require('lspconfig')
local utils = require('utils')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false, signs = false})

lspconfig.tsserver.setup({autostart = false})
lspconfig.rust_analyzer.setup({autostart = false})

utils.nnoremap('<Leader>ld', ':lua vim.lsp.buf.definition()<CR>')
utils.nnoremap('<Leader>lk', ':lua vim.lsp.buf.hover()<CR>')
utils.nnoremap('<Leader>lf', ':lua vim.lsp.buf.references()<CR>')
utils.nnoremap('<Leader>lr', ':lua vim.lsp.buf.rename()<CR>')
utils.nnoremap('<Leader>l[', ':lua vim.diagnostic.goto_prev()<CR>')
utils.nnoremap('<Leader>l]', ':lua vim.diagnostic.goto_next()<CR>')
utils.nnoremap('<Leader>lq', ':lua usr.lsp.load_diagnostics_to_quickfix_list()<CR>')

_G.usr.lsp = {
    load_diagnostics_to_quickfix_list = function()
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
}
