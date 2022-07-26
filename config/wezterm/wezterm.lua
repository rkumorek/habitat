local wezterm = require('wezterm');

local is_macos = string.find(wezterm.target_triple, 'apple-darwin', 0, true) and true or false

local leader = function(mods)
    if mods == nil or #mods == 0 then
        return 'LEADER'
    end

    return 'LEADER|' .. table.concat(mods, '|')
end

local send_cmd_as_ctrl = function (shortcuts)
    if not is_macos then
        return shortcuts
    end

    local keys = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
        'z', '[', ']', '\\',
    };

    for _, key in ipairs(keys) do
        table.insert(shortcuts, {
            key = key,
            mods = 'CMD',
            action = { SendKey = { key = key, mods = 'CTRL' } },
        });
    end

    return shortcuts
end

local action = function(type, args)
    return wezterm.action({
        [type] = args
    })
end

return {
    disable_default_key_bindings = true,
    font = wezterm.font('JetBrains Mono NL'),
    font_size = 20.0,
    colors = {
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
    },
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = send_cmd_as_ctrl({
        { key = 'a', mods = leader({ 'CTRL' }), action = { SendKey = { key = 'a', mods = 'CTRL' } } },
        { key = 'c', mods = leader(), action = action('SpawnTab', 'CurrentPaneDomain') },
        { key = 'x', mods = leader(), action = action('CloseCurrentTab', { confirm = true }) },
        { key = '"', mods = leader({ 'SHIFT' }), action = action('SplitHorizontal', { domain = 'CurrentPaneDomain' }) },
        { key = '%', mods = leader({ 'SHIFT' }), action = action('SplitVertical', { domain = 'CurrentPaneDomain' }) },
        { key = 'h', mods = leader(), action = action('ActivatePaneDirection', 'Left') },
        { key = 'j', mods = leader(), action = action('ActivatePaneDirection', 'Down') },
        { key = 'k', mods = leader(), action = action('ActivatePaneDirection', 'Up') },
        { key = 'l', mods = leader(), action = action('ActivatePaneDirection', 'Right') },
        { key = "h", mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Left', 7 }) },
        { key = "j", mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Down', 5 }) },
        { key = "k", mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Up', 5 }) },
        { key = "l", mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Right', 9 }) },
        { key = 'f', mods = leader(), action = action('ScrollByPage', 1) },
        { key = 'b', mods = leader(), action = action('ScrollByPage', -1) },
        { key = 'n', mods = leader(), action = action('ActivateTabRelative', 1) },
        { key = 'p', mods = leader(), action = action('ActivateTabRelative', -1) },
    }),
}

