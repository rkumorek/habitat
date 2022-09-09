return function(config)
    config.use_fancy_tab_bar = false
    config.window_frame = {
        font_size = 14.0,
    }
    config.colors = {
        cursor_bg = '#D3866D',
        cursor_border = '#D3866D',
        selextion_fg = '#EBDBB2',
        selection_bg = '#A89984',
        tab_bar = {
            background = '#3C3836',
            active_tab = {
                bg_color = '#282828',
                fg_color = '#EBDBB2',
                intensity = 'Bold',
                underline = 'Single',
            },
            inactive_tab = {
                bg_color = '#282828',
                fg_color = '#A89984',
            },
            inactive_tab_hover = {
                bg_color = '#665c54',
                fg_color = '#A89984',
            },
            new_tab = {
                bg_color = '#3C3836',
                fg_color = '#FE8019',
                intensity = 'Bold',
            },
            new_tab_hover = {
                bg_color = '#FE8019',
                fg_color = '#3C3836',
                intensity = 'Bold',
            },
        },
    }
end
