local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local gears = require('gears')

local signals = require('signals')

local M = {}

-- M.search = wibox.widget {}

M.layout = function(s)
    return awful.widget.layoutbox {
        screen = s,
        buttons = {
            awful.button {
                modifiers = {},
                button    = 1,
                on_press  = function() awful.layout.inc(1) end,
            },
            awful.button {
                modifiers = {},
                button    = 3,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button {
                modifiers = {},
                button    = 4,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button {
                modifiers = {},
                button    = 5,
                on_press  = function() awful.layout.inc(1) end,
            },
        }
    }
end

M.sep = wibox.widget {
    {
        forced_height = 2,
        shape = gears.shape.line,
        widget = wibox.widget.separator,
    },
    widget = wibox.container.margin
}

M.volume = wibox.widget {
    font = beautiful.iconfont .. "14",
    align = 'center',
    widget = wibox.widget.textbox,
    buttons = {
        awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function() awesome.emit_signal("toggle::vol") end,
        },
    }
}

M.net = wibox.widget {
    font = beautiful.iconfont .. "14",
    align = 'center',
    markup = "\u{f1eb}\u{2009}\u{2009}",
    widget = wibox.widget.textbox,
}

M.battery = wibox.widget {
    font = beautiful.iconfont,
    align = 'center',
    widget = wibox.widget.textbox,
}

M.clock = wibox.widget {
    font = beautiful.barfont,
    format = "%H\n%M",
    refresh = 1,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock,
    buttons = {
        awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function() awesome.emit_signal("toggle::cal") end,
        },
    }
}

awesome.connect_signal("net::value", function(status)
    if status == 1 then
        M.net.opacity = 1
    else
        M.net.opacity = 0.25
    end
end)

awesome.connect_signal("bat::value", function(status, charge)
    local icon = "\u{f240}"
    if charge <= 25 then
        icon = "\u{f243}"
    elseif charge > 25 and charge <= 50 then
        icon = "\u{f242}"
    elseif charge > 50 and charge <= 75 then
        icon = "\u{f241}"
    end
    M.battery.markup = icon .. "\u{2009}\u{2009}\u{2009}"
end)

awesome.connect_signal("toggle::vol", function()
    awful.spawn.with_shell("amixer -D pulse set Master 1+ toggle")
    signals.vol()
end)

awesome.connect_signal("vol::value", function(muted, volume)
    local icon = "\u{f027}"
    if muted == 1 then
        icon = "\u{f026}"
    elseif volume == 0 then
        icon = "\u{f026}"
    elseif volume > 15 then
        icon = "\u{f028}"
    end
    M.volume.markup = icon .. "\u{2009}"
end)

return M
