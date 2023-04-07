local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local gears = require('gears')

local soundboard_widget = function(title, initial_value)
    return wibox.widget {
        {
            {
                {
                    bar_height = 4,
                    handle_width = 13,
                    forced_width = 210,
                    value = initial_value,
                    widget = wibox.widget.slider
                },
                top = 10,
                bottom = 10,
                widget = wibox.container.margin
            },
            direction = "east",
            widget = wibox.container.rotate
        },
        {
            {
                text = title,
                align = "center",
                ellipsize = "end",
                widget = wibox.widget.textbox
            },
            {
                text = initial_value .. '%',
                align = "center",
                widget = wibox.widget.textbox
            },
            widget = wibox.layout.fixed.vertical
        },
        spacing = 5,
        layout = wibox.layout.fixed.vertical
    }
end

awful.screen.connect_for_each_screen(function(s)
    local soundboard = wibox({
        type = "dock",
        ontop = true,
        visible = false,
        bg = beautiful.bg,
        screen = s,
        width = 510,
        height = 320
    })

    soundboard:setup {
        {
            {
                soundboard_widget("tesasf", 10),
                soundboard_widget("svdhsdg", 4),
                soundboard_widget("aaaaaaaaaaaaaaaaa", 100),
                soundboard_widget("bbbbbbbbbbbbbbbbb", 40),
                soundboard_widget("svdhsdg", 52),
                spacing = 7,
                layout = wibox.layout.flex.horizontal
                --[[ step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                max_size = 100,
                speed = 400,
                layout = wibox.container.scroll.horizontal, ]]
            },
            margins = 40,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
    }

    awful.placement.bottom_left(soundboard, { honor_workarea = true, margins = beautiful.useless_gap * 2 })
    awesome.connect_signal("toggle::sound", function()
        soundboard.visible = not soundboard.visible
    end)
end)
