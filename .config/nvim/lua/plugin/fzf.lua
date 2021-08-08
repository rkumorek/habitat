local utils = require('utils')

local nnoremap = utils.nnoremap;

nnoremap('<Leader>ff', ':FZF<CR>')
nnoremap('<Leader>fd', ':GFiles<CR>')
nnoremap('<Leader>fs', ':GFiles?<CR>')
nnoremap('<Leader>fb', ':Buffers<CR>')
nnoremap('<Leader>fr', ':Rg<CR>')
nnoremap('<Leader>fl', ':Lines<CR>')
nnoremap('<Leader>f;', ':History:<CR>')
nnoremap('<Leader>f:', ':Commands<CR>')
nnoremap('<Leader>fc', ':Commits<CR>')
nnoremap('<Leader>fv', ':BCommits<CR>')
nnoremap('<Leader>fh', ':Helptags<CR>')
nnoremap('<Leader>fm', ':Maps<CR>')
nnoremap("<Leader>f'", ':Marks<CR>')

vim.env.FZF_DEFAULT_COMMAND = 'fd --hidden --color never'
