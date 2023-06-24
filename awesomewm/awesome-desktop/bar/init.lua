local awful = require("awful")

local wibox = require("wibox")

local beautiful = require("beautiful")

local gears = require("gears")

local tags = require("bar.tag")
local modules = require("bar.modules")

local tags_widget = function(s)
    return wibox.widget {
        {
            {
                {
                    {
                        {
                            {
                                modules.layout(s),
                                margins = { top = 4, bottom = 4, left = 15, right = 15 },
                                widget = wibox.container.margin
                            },
                            bg = '#E8E3E3',
                            shape = gears.shape.rect,
                            widget = wibox.container.background
                        },
                        margins = { top = 10, bottom = 10, right = 10 },
                        widget = wibox.container.margin
                    },
                    tags(s),
                    modules.sep,
                    modules.clock,
                    spacing = 5,
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = { left = 10, right = 10 },
                widget = wibox.container.margin
            },
            bg = beautiful.bg,
            widget = wibox.container.background
        },
        modules.music,
        spacing = 15,
        layout = wibox.layout.fixed.horizontal,
    }
end

awful.screen.connect_for_each_screen(function(s)
    awful.tag(
        { "一", "二", "三", "四", "五", "六", "七", "八", "九" }, s,
        awful.layout.layouts[1]
    )

    awful.wibar ({
        position = "top",
        align = "left",
        bg = beautiful.bg .. '00',
        fg = beautiful.fg,
        height = beautiful.bar_size,
        width = beautiful.max_width - 20,
        screen = s,
        margins = {top = 10, left = 10},
    }):setup {
        tags_widget(s),
        expand = "none",
        layout = wibox.layout.align.horizontal,
    }
end)
