vim.bo.syntax = 'dirvish'
vim.keymap.set('n', '<Leader>dr', usr.dirvish_rename, { buffer = true })
vim.keymap.set('n', '<Leader>da', usr.dirvish_create, { buffer = true })
vim.keymap.set('n', '<Leader>dd', usr.dirvish_remove, { buffer = true })
