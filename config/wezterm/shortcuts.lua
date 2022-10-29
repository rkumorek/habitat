local wezterm = require('wezterm');

-- Check if the system is MacOS - useful for mapping CMD+<key> into CTRL+<key>
local is_macos = string.find(wezterm.target_triple, 'apple-darwin', 0, true) and
                     true or false

local send_cmd_as_ctrl = function(shortcuts)
    if not is_macos then return shortcuts end

    local keys = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '[', ']',
        '\\'
    };

    for _, key in ipairs(keys) do
        table.insert(shortcuts, {
            key = key,
            mods = 'CMD',
            action = { SendKey = { key = key, mods = 'CTRL' } }
        });
    end

    return shortcuts
end

-- on MacOS returns CMD modifier, otherwise returns CTRL
local ctrl_or_cmd = function()
    if is_macos then return 'CMD' end

    return 'CTRL'
end

-- Returns 'LEADER' or 'LEADER|CTRL...'
local leader = function(mods)
    if mods == nil or #mods == 0 then return 'LEADER' end

    return 'LEADER|' .. table.concat(mods, '|')
end

-- Inserts tab shortcuts to global shortcuts
local set_tab_shortcuts = function(shortcuts)
    local i = 1

    while i <= 9 do
        table.insert(shortcuts, {
            key = tostring(i),
            mods = leader(),
            action = wezterm.action.ActivateTab(i - 1)
        });

        i = i + 1
    end
end

local set_key_tables = function(config, shortcuts)
    -- Easier ui control
    local ui = {
        -- Resize pane size
        {
            key = 'h',
            mods = 'CTRL',
            action = wezterm.action.AdjustPaneSize({ 'Left', 1 })
        }, {
            key = 'j',
            mods = 'CTRL',
            action = wezterm.action.AdjustPaneSize({ 'Down', 1 })
        },
        {
            key = 'k',
            mods = 'CTRL',
            action = wezterm.action.AdjustPaneSize({ 'Up', 1 })
        }, {
            key = 'l',
            mods = 'CTRL',
            action = wezterm.action.AdjustPaneSize({ 'Right', 1 })
        }, -- Change font size
        { key = '=', action = wezterm.action.IncreaseFontSize },
        { key = '-', action = wezterm.action.DecreaseFontSize },
        { key = '0', action = wezterm.action.ResetFontSize }, -- Scrollback
        { key = 'f', action = wezterm.action.ScrollByPage(1) },
        { key = 'b', action = wezterm.action.ScrollByPage(-1) },
        { key = 'd', action = wezterm.action.ScrollByPage(0.5) },
        { key = 'u', action = wezterm.action.ScrollByPage(-0.5) }, -- Exit 
        { key = 'Escape', action = wezterm.action.PopKeyTable },
        { key = '[', mods = ctrl_or_cmd(), action = wezterm.action.PopKeyTable }
    }

    config.key_tables = { ui = ui }

    table.insert(shortcuts, {
        key = 'r',
        mods = leader(),
        action = wezterm.action.ActivateKeyTable(
            { name = 'ui', one_shot = false })
    });
end

local set_tmux_like_shortcuts = function(shortcuts)
    local keys = {
        {
            key = 'a',
            mods = leader({ 'CTRL' }),
            action = { SendKey = { key = 'a', mods = 'CTRL' } }
        }, {
            key = 'c',
            mods = leader(),
            action = wezterm.action.SpawnTab('CurrentPaneDomain')
        }, {
            key = 'x',
            mods = leader(),
            action = wezterm.action.CloseCurrentPane({ confirm = true })
        }, {
            key = '"',
            mods = leader({ 'SHIFT' }),
            action = wezterm.action.SplitHorizontal({
                domain = 'CurrentPaneDomain'
            })
        }, {
            key = '%',
            mods = leader({ 'SHIFT' }),
            action = wezterm.action.SplitVertical(
                { domain = 'CurrentPaneDomain' })
        }, {
            key = 'h',
            mods = leader(),
            action = wezterm.action.ActivatePaneDirection('Left')
        }, {
            key = 'j',
            mods = leader(),
            action = wezterm.action.ActivatePaneDirection('Down')
        }, {
            key = 'k',
            mods = leader(),
            action = wezterm.action.ActivatePaneDirection('Up')
        }, {
            key = 'l',
            mods = leader(),
            action = wezterm.action.ActivatePaneDirection('Right')
        },
        {
            key = 'n',
            mods = leader(),
            action = wezterm.action.ActivateTabRelative(1)
        },
        {
            key = 'p',
            mods = leader(),
            action = wezterm.action.ActivateTabRelative(-1)
        }
    }

    for i, k in ipairs(keys) do table.insert(shortcuts, k) end
end

-- Show which key table is active in the status area
wezterm.on('update-status', function(window, pane)
    local name = window:active_key_table()
    if name then name = '[' .. name .. ']' end
    window:set_left_status(name or '')
end)

return function(config)
    config.leader = { key = ';', mods = 'CMD', timeout_milliseconds = 1000 }

    local shortcuts = {}

    set_tab_shortcuts(shortcuts)
    set_key_tables(config, shortcuts)
    set_tmux_like_shortcuts(shortcuts)

    config.keys = send_cmd_as_ctrl(shortcuts)
end
