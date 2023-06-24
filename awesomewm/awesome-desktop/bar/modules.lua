local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local gears = require('gears')

local signals = require('signals')

local watch = require("awful.widget.watch")

local M = {}

-- M.search = wibox.widget {}

M.layout = function(s)
    local layout_widget = wibox.widget {
        text = '[]=',
        align = 'center',
        font = beautiful.font .. '12',
        widget = wibox.widget.textbox,
        buttons = {
            awful.button {
                modifiers = {},
                button    = 1,
                on_press  = function()
                    awful.layout.inc(1)
                    awesome.emit_signal("button::change_layout")
                end,
            },
            awful.button {
                modifiers = {},
                button    = 3,
                on_press  = function()
                    awful.layout.inc(-1)
                    awesome.emit_signal("button::change_layout")
                end,
            },
            awful.button {
                modifiers = {},
                button    = 4,
                on_press  = function()
                    awful.layout.inc(-1)
                    awesome.emit_signal("button::change_layout")
                end,
            },
            awful.button {
                modifiers = {},
                button    = 5,
                on_press  = function()
                    awful.layout.inc(1)
                    awesome.emit_signal("button::change_layout")
                end,
            },
        }
    }

    local background_widget = wibox.widget {
        layout_widget,
        fg = "#141414",
        widget = wibox.container.background
    }

    awesome.connect_signal("button::change_layout", function()
        local layout_name = awful.layout.get(s).name
        layout_widget.text = layout_name
        if layout_name == "tile" then
            layout_widget.text = "[]="
        elseif layout_name == "floating" then
            layout_widget.text = "><>"
        elseif layout_name == "fairv" then
            layout_widget.text = "HHH"
        end
    end)

    return background_widget
end

M.sep = wibox.widget {
    {
        thickness = 2,
        forced_width = 2,
        orientation = "vertical",
        color = "#E8E3E3",
        widget = wibox.widget.separator,
    },
    margins = 12,
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
            on_press  = function() awesome.emit_signal("toggle::sound") end,
        },
    }
}

M.net = wibox.widget {
    font = beautiful.iconfont .. "14",
    align = 'center',
    markup = "\u{f1eb}\u{2009}\u{2009}",
    widget = wibox.widget.textbox,
}

--[[ M.battery = wibox.widget {
    font = beautiful.iconfont,
    align = 'center',
    widget = wibox.widget.textbox,
} ]]

--[[ local background_widget = wibox.widget {
    layout_widget,
    fg = "#141414",
    widget = wibox.container.background
} ]]

M.clock = wibox.widget {
    {
        font = beautiful.barfont,
        format = "%H:%M",
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
    },
    widget = wibox.container.background
}

M.music = wibox.widget {
    {
        font = beautiful.iconfont .. "12",
        align = 'left',
        id = 'music-text',
        widget = wibox.widget.textbox,
    },
    fg = beautiful.bg,
    visible = false,
    id = 'music-widget',
    widget = wibox.container.background
}

local update_music_widget = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    widget:get_children_by_id('music-text')[1].text = stdout
end

local update_music_widget_status = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    widget:get_children_by_id('music-widget')[1].visible = stdout ~= "No players found" and true or false
end

watch('playerctl -p spotify metadata --format "[{{album}}] {{title}} - {{artist}}"', 1, update_music_widget, M.music)
watch('playerctl -p spotify status', 1, update_music_widget_status, M.music)

awesome.connect_signal("net::value", function(status)
    if status == 1 then
        M.net.opacity = 1
    else
        M.net.opacity = 0.25
    end
end)

--[[ awesome.connect_signal("bat::value", function(status, charge)
    local icon = "\u{f240}"
    if charge <= 25 then
        icon = "\u{f243}"
    elseif charge > 25 and charge <= 50 then
        icon = "\u{f242}"
    elseif charge > 50 and charge <= 75 then
        icon = "\u{f241}"
    end
    M.battery.markup = icon .. "\u{2009}\u{2009}\u{2009}"
end) ]]

awesome.connect_signal("toggle::vol", function()
    awful.spawn.with_shell("amixer -D pulse set Master 1+ toggle")
    signals.vol()
end)

--[[ awesome.connect_signal("vol::value", function(muted, volume)
    local icon = "\u{f027}"
    if muted == 1 then
        icon = "\u{f026}"
    elseif volume == 0 then
        icon = "\u{f026}"
    elseif volume > 15 then
        icon = "\u{f028}"
    end
    M.volume.markup = icon .. "\u{2009}"
end) ]]

return M
