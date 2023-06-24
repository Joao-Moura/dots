local gears = require("gears")

local awful = require("awful")

local wibox = require("wibox")

local beautiful = require("beautiful")

local gears_rounded_rect = function (radius)
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end

local create_button = function (width, bg_color, onclick_function)
    return function (c)
        local button = wibox.widget {
            wibox.widget.textbox(),
            forced_width = width,
            forced_height = 10,
            bg = bg_color,
            shape = gears_rounded_rect(3),
            widget = wibox.container.background
        }

        client.connect_signal("property::active", function()
            if c.active then
                button.bg = bg_color
            else
                button.bg = "#424242"
            end
        end)

        button:add_button(awful.button({}, 1, function()
            if onclick_function then
                onclick_function(c)
            end
        end))

        return button
    end
end

    local close_button = create_button(70, "#DD6777", function (c)
    c:kill()
end)

local minimize_button = create_button(35, "#ECD3A0", function (c)
    gears.timer.delayed_call(function()
        c.minimized = not c.minimized
    end)
end)

local maximize_button = create_button(35, "#90CEAA", function (c)
    c.maximized = not c.maximized
end)

client.connect_signal("request::titlebars", function(c)
    if c.requests_no_titlebar then
        return
    end

    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local custom_titlebar = awful.titlebar(c, {
        size = 30,
        bg = beautiful.bg
    })
    custom_titlebar.widget = {
        {
            {
                close_button(c),
                maximize_button(c),
                minimize_button(c),
                spacing = 5,
                layout = wibox.layout.fixed.horizontal
            },
            margins = 9,
            widget = wibox.container.margin
        },
        {
            {
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        nil,
        layout = wibox.layout.align.horizontal
    }
end)
