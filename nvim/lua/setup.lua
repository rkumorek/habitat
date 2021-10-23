-- Global variable for user defined values
_G.usr = {
    -- Load plugin configuration files
    init_plugins = function()
        require('plugin.gruvbox')
        require('plugin.fzf')
        require('plugin.lspconfig')
        require('plugin.dirvish')
        require('plugin.nvim-treesitter')
    end,
    -- Sync plugins using packer.nvim
    sync_plugins = function()
        local packer = require('packer')

        packer.startup(function()
            packer.use_rocks('luafilesystem')

            packer.use('wbthomason/packer.nvim')
            packer.use({'junegunn/fzf', run = './install --bin'})
            packer.use('junegunn/fzf.vim')
            packer.use('tpope/vim-fugitive')
            packer.use('justinmk/vim-dirvish')
            packer.use('gruvbox-community/gruvbox')
            packer.use('neovim/nvim-lspconfig')
            packer.use('nvim-treesitter/nvim-treesitter')
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
        vim.cmd('packadd packer.nvim');
        vim.cmd('autocmd User PackerComplete ++once lua usr.init_plugins()')
        _G.usr.sync_plugins()
    else
        _G.usr.init_plugins()
    end
end

load_plugins()
