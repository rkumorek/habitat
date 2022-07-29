local wezterm = require('wezterm')
local colors = require('colors')
local shortcuts = require('shortcuts')

local config = {
    disable_default_key_bindings = true,
    font = wezterm.font({
        family = 'Iosevka',
        weight = 'Regular'
    }),
    font_size = 21.0,
}

shortcuts(config)
colors(config)

return config
