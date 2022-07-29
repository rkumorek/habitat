return function(config)
    config.colors = {
        compose_cursor = '#B16286',
        cursor_bg = '#D3866D',
        cursor_border = '#D3866D',
        selextion_fg = '#EBDBB2',
        selection_bg = '#A89984',
        tab_bar = {
            background = '#3C3836',
            active_tab = {
                bg_color = '#282828',
                fg_color = '#EBDBB2',
            },
            inactive_tab = {
                bg_color = '#282828',
                fg_color = '#A89984',
            },
            inactive_tab_hover = {
                bg_color = '#282828',
                fg_color = '#BDAE93',
                italic = false,
            },
            new_tab = {
                bg_color = '#3C3836',
                fg_color = '#FE8019',
                italic = false,
                intensity = 'Bold',
            },
            new_tab_hover = {
                bg_color = '#504954',
                fg_color = '#FE8019',
                italic = false,
            },
        },
    }
end
