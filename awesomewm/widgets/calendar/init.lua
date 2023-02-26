local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local gears = require('gears')

local calendar_widget = wibox.widget {
    date = os.date('*t'),
    font = beautiful.calendar_font,
    long_weekdays = true,
    start_sunday = true,
    widget = wibox.widget.calendar.month,
    fn_embed = function(widget, flag, date)
        widget.align = 'center'
        widget.valign = 'center'
        if flag == 'weekday' or flag == 'header' then
            widget.text = widget.text:gsub("%a", string.upper, 1)
        end

        if flag == 'header' then
            widget.text = widget.text:gsub(" ", " de ")
            widget.font = beautiful.font .. '14'
        end

        return wibox.widget {
            {
                {
                    widget,
                    left = 2,
                    right = 2,
                    top = 5,
                    bottom = 5,
                    widget = wibox.container.margin
                },
                shape = flag == 'focus' and gears.shape.circle or nil,
                bg = flag == 'focus' and '#191919' or nil,
                -- shape_border_width = 1,
                widget = wibox.container.background
            },
            widget = wibox.container.margin
        }
    end
}

awful.screen.connect_for_each_screen(function(s)
    local calendar = wibox({
        type = "dock",
        ontop = true,
        visible = false,
        bg = beautiful.bg,
        screen = s,
        width = 320,
        height = 310
    })

    calendar:setup {
        nil,
        {
            nil,
            calendar_widget,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical,
    }

    awful.placement.bottom_left(calendar, { honor_workarea = true, margins = beautiful.useless_gap * 2 })
    awesome.connect_signal("toggle::cal", function()
        calendar.visible = not calendar.visible
    end)
end)
