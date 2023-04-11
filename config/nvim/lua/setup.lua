-- Global variable for user defined values
_G.usr = {
    -- Load path completion
    path_completion = require('./path-completion'),
    -- Load plugin configuration files
    init_plugins = function()
        require('plugin.lspconfig')
        require('plugin.dirvish')
        require('plugin.nvim-treesitter')
        require('plugin.telescope')

    end,
    -- Sync plugins using packer.nvim
    sync_plugins = function()
        local packer = require('packer')

        packer.startup(function()
            -- Plugins
            packer.use('wbthomason/packer.nvim')
            packer.use('tpope/vim-fugitive')
            packer.use('justinmk/vim-dirvish')
            packer.use('neovim/nvim-lspconfig')
            packer.use('nvim-treesitter/nvim-treesitter')
            packer.use('nvim-lua/plenary.nvim')
            packer.use('nvim-telescope/telescope.nvim')
            packer.use('nvim-telescope/telescope-fzy-native.nvim')

            -- Color schemes
            packer.use('gruvbox-community/gruvbox')
            packer.use('jnurmine/Zenburn')
            packer.use('sainnhe/everforest')
            packer.use('savq/melange')
        end)

        packer.sync()
    end
}

-- Loads installed plugins.
-- If necessary clones packer.nvim and istalls it in the 'packpath'.
local function load_plugins()
    -- Check if packer is installed.
    local packer_path = vim.fn.stdpath('data') ..
                            '/site/pack/packer/start/packer.nvim'
    local packer_installed = vim.fn.isdirectory(packer_path) == 1

    -- Install Packer and plugins.
    if not packer_installed then
        vim.cmd(
            'silent !git clone https://github.com/wbthomason/packer.nvim ' ..
                packer_path)
        vim.cmd('packadd packer.nvim')
        vim.cmd('autocmd User PackerComplete ++once lua usr.init_plugins()')
        _G.usr.sync_plugins()
    else
        _G.usr.init_plugins()
    end
end

load_plugins()

-- :lua usr.preview_highlights()
-- _G.usr.preview_highlights = function()
--     local bufnr = vim.fn.bufnr()
--     local highlights = {
--         "DiagnosticError",
--         "DiagnosticUnderlineError",
--         "DiagnosticWarn",
--         "DiagnosticUnderlineWarn",
--         "DiagnosticInfo",
--         "DiagnosticUnderlineInfo",
--         "DiagnosticHint",
--         "DiagnosticUnderlineHint",
--     }
-- 
--     vim.api.nvim_buf_clear_namespace(bufnr, 0, 0, -1)
--     for i, k in ipairs(highlights) do
--         vim.api.nvim_buf_add_highlight(bufnr, 0, k, i - 1, 0, -1)
--     end
-- end
