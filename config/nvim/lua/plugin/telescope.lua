local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')

telescope.setup({
    defaults = {
        path_display = { 'truncate' },
        layout_strategy = 'vertical',
        layout_config = { height = 0.95, width = 0.95, preview_cutoff = 20 },
        history = false,
        color_devicons = false,
        preview = { msg_bg_fillchar = ' ' },
        mappings = {
            i = {
                ['<Tab>'] = false,
                ['<S-Tab>'] = false,
                ['<C-\\>'] = function(prompt_bufnr)
                    action_state.get_current_picker(prompt_bufnr):reset_prompt()
                end,
                ['<C-j>'] = function(prompt_bufnr)
                    action_set.shift_selection(prompt_bufnr, 5)
                end,
                ['<C-k>'] = function(prompt_bufnr)
                    action_set.shift_selection(prompt_bufnr, -5)
                end,
                ['<C-s>'] = actions.toggle_selection,
                ['<C-g>'] = actions.toggle_all
            },
            n = {
                ['<Tab>'] = false,
                ['<S-Tab>'] = false,
                ['<C-j>'] = function(prompt_bufnr)
                    action_set.shift_selection(prompt_bufnr, 5)
                end,
                ['<C-k>'] = function(prompt_bufnr)
                    action_set.shift_selection(prompt_bufnr, -5)
                end,
                ['<C-s>'] = actions.toggle_selection,
                ['<C-g>'] = actions.toggle_all,
                ['<Leader>x'] = actions.delete_buffer
            }
        }
    },
})

telescope.load_extension('fzy_native')

local buffers = function()
    return builtin.buffers(
               { previewer = false, layout_config = { height = 0.5 } })
end

local find_files = function()
    return builtin.find_files({
        previewer = false,
        layout_config = { height = 0.5 },
        find_command = { 'fd', '--hidden', '--color=never' }
    })
end

vim.keymap.set('n', '<Leader>ff', find_files)
vim.keymap.set('n', '<Leader>fb', buffers)
vim.keymap.set('n', '<Leader>fr', builtin.live_grep)
vim.keymap.set('n', '<Leader>fh', builtin.help_tags)
vim.keymap.set('n', '<Leader>ft', builtin.resume)
vim.keymap.set('n', '<Leader>fa', function()
    vim.cmd('Telescope')
end)
