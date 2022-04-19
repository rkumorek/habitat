local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
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
        mappings = {
            i = {
                ['<Tab>'] = false,
                ['<S-Tab>'] = false,
                ['<C-j>'] = actions.toggle_selection,
                ['<C-u>'] = function (prompt_bufnr)
                    action_state.get_current_picker(prompt_bufnr):reset_prompt()
                end,
            },
            n = {
                ['<Tab>'] = false,
                ['<S-Tab>'] = false,
                ['<C-j>'] = actions.toggle_selection,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
})

telescope.load_extension('fzy_native')

local buffers = function ()
    return builtin.buffers({
        previewer = false,
        layout_config = { height = 0.5 },
    })
end

local find_files = function ()
    return builtin.find_files({
        previewer = false,
        layout_config = { height = 0.5 },
        find_command = { "fd", "--hidden", "--color=never" },
    })
end

vim.keymap.set('n', '<Leader>ff', find_files)
vim.keymap.set('n', '<Leader>fb', buffers)
vim.keymap.set('n', '<Leader>fr', builtin.live_grep)
vim.keymap.set('n', '<Leader>fh', builtin.help_tags)
vim.keymap.set('n', '<Leader>ft', builtin.resume)
