local wezterm = require('wezterm');

local send_cmd_as_ctrl = function (shortcuts)
    -- Check if the system is MacOS - useful for mapping CMD+<key> into CTRL+<key>
    local is_macos = string.find(wezterm.target_triple, 'apple-darwin', 0, true) and true or false

    if not is_macos then
        return shortcuts
    end

    local keys = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
        'y', 'z', '[', ']', '\\',
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

-- mods - an array of strings
-- Returns 'LEADER' or 'LEADER|CTRL...'
local leader = function(mods)
    if mods == nil or #mods == 0 then
        return 'LEADER'
    end

    return 'LEADER|' .. table.concat(mods, '|')
end

local action = function(type, args)
    return wezterm.action[type](args)
end

return function(config)
    config.leader = { key = ';', mods = 'CMD', timeout_milliseconds = 1000 }
    config.keys = send_cmd_as_ctrl({
        { key = 'a', mods = leader({ 'CTRL' }), action = { SendKey = { key = 'a', mods = 'CTRL' } } },
        { key = 'c', mods = leader(), action = action('SpawnTab', 'CurrentPaneDomain') },
        { key = 'x', mods = leader(), action = action('CloseCurrentTab', { confirm = true }) },
        { key = '"', mods = leader({ 'SHIFT' }), action = action('SplitHorizontal', { domain = 'CurrentPaneDomain' }) },
        { key = '%', mods = leader({ 'SHIFT' }), action = action('SplitVertical', { domain = 'CurrentPaneDomain' }) },
        { key = 'h', mods = leader(), action = action('ActivatePaneDirection', 'Left') },
        { key = 'j', mods = leader(), action = action('ActivatePaneDirection', 'Down') },
        { key = 'k', mods = leader(), action = action('ActivatePaneDirection', 'Up') },
        { key = 'l', mods = leader(), action = action('ActivatePaneDirection', 'Right') },
        { key = 'h', mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Left', 8 }) },
        { key = 'j', mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Down', 5 }) },
        { key = 'k', mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Up', 5 }) },
        { key = 'l', mods = leader({ 'CTRL' }), action = action('AdjustPaneSize', { 'Right', 8 }) },
        { key = 'f', mods = leader(), action = action('ScrollByPage', 1) },
        { key = 'b', mods = leader(), action = action('ScrollByPage', -1) },
        { key = 'n', mods = leader(), action = action('ActivateTabRelative', 1) },
        { key = 'p', mods = leader(), action = action('ActivateTabRelative', -1) },
        { key = '=', mods = leader(), action = wezterm.action.IncreaseFontSize },
        { key = '-', mods = leader(), action = wezterm.action.DecreaseFontSize },
        { key = '0', mods = leader(), action = wezterm.action.ResetFontSize },
    })
end
