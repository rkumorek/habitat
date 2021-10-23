local telescope = require('telescope')
local builtin = require('telescope.builtin')
local utils = require('utils')

telescope.setup({
    defaults = {
        path_display = { "truncate" },
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.95,
            width = 0.95,
            preview_cutoff = 20,
        },
        history = false,
        color_devicons = false,
        preview = { msg_bg_fillchar = ' ' },
    }
})

_G.usr.telescope = {
    buffers = function ()
        return builtin.buffers()
    end,
    find_files = function ()
        return builtin.find_files({ previewer = false, find_command = { "fd", "--hidden", "--color=never" } })
    end,
    grep = function ()
        return builtin.live_grep()
    end,
    help = function ()
        return builtin.help_tags()
    end,
}

utils.nnoremap('<Leader>ff', ':lua usr.telescope.find_files()<CR>')
utils.nnoremap('<Leader>fb', ':lua usr.telescope.buffers()<CR>')
utils.nnoremap('<Leader>fr', ':lua usr.telescope.grep()<CR>')
utils.nnoremap('<Leader>fn', ':lua usr.telescope.help()<CR>')
