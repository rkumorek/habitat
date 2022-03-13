local parser_config = require"nvim-treesitter.parsers".get_parser_configs()

require('nvim-treesitter.configs').setup({
    highlight = {enable = false},
    indent = {enable = false}
})
