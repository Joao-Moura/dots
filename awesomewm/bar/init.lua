local awful = require("awful")

local wibox = require("wibox")

local beautiful = require("beautiful")

local tags = require("bar.tag")
local modules = require("bar.modules")

local tags_widget = function(s)
    return wibox.widget {
        tags(s),
        layout = wibox.layout.fixed.vertical,
    }
end

local modules_widget = wibox.widget {
    {
        modules.sep,
        modules.clock,
        layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
}

awful.screen.connect_for_each_screen(function(s)
    awful.tag(
        { "一", "二", "三", "四", "五", "六", "七", "八", "九" }, s,
        awful.layout.layouts[1]
    )

    awful.wibar ({
        position = "left",
        bg = beautiful.bg,
        fg = beautiful.fg,
        width = beautiful.bar_width,
        -- shape = help.rrect(beautiful.bar_br),
        screen = s,
    }):setup {
        nil,
        tags_widget(s),
        modules_widget,
        expand = "none",
        layout = wibox.layout.align.vertical,
    }
end)
