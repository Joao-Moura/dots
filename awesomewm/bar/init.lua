local awful = require("awful")

local wibox = require("wibox")

local beautiful = require("beautiful")

local tags = require("bar.tag")
local modules = require("bar.modules")

local top_widgets = function(s)
    return wibox.widget {
        {
            modules.layout(s),
            spacing = 5,
            layout = wibox.layout.fixed.vertical,
        },
        top = 5,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    }
end

local tags_widget = function(s)
    return wibox.widget {
        tags(s),
        layout = wibox.layout.fixed.vertical,
    }
end

local botton_widgets = wibox.widget {
    {
        {
            modules.volume,
            modules.net,
            modules.battery,
            spacing = 7,
            layout = wibox.layout.fixed.vertical,
        },
        -- modules.sep,
        modules.clock,
        spacing = 10,
        layout = wibox.layout.fixed.vertical,
    },
    bottom = 5,
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
        screen = s,
    }):setup {
        top_widgets(s),
        tags_widget(s),
        botton_widgets,
        expand = "none",
        layout = wibox.layout.align.vertical,
    }
end)
