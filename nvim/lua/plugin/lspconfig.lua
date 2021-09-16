local lspconfig = require('lspconfig')
local utils = require('utils')

local nnoremap = utils.nnoremap

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false, signs = false})

lspconfig.tsserver.setup({autostart = false})
lspconfig.rust_analyzer.setup({autostart = false})

nnoremap('<Leader>ld', ':lua vim.lsp.buf.definition()<CR>')
nnoremap('<Leader>lk', ':lua vim.lsp.buf.hover()<CR>')
nnoremap('<Leader>lf', ':lua vim.lsp.buf.references()<CR>')
nnoremap('<Leader>lr', ':lua vim.lsp.buf.rename()<CR>')
nnoremap('<Leader>l[', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
nnoremap('<Leader>l]', ':lua vim.lsp.diagnostic.goto_next()<CR>')
nnoremap('<Leader>lq', ':lua usr.lsp.load_diagnostics_to_quickfix_list()<CR>')

_G.usr.lsp = {
    load_diagnostics_to_quickfix_list = function()
        local locations = {}
        local empty = true

        for bufnr, diagnostics in pairs(vim.lsp.diagnostic.get_all()) do
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

        vim.lsp.util.set_qflist(locations)
        vim.cmd('cwindow')
    end
}
