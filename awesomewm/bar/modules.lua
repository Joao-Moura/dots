local beautiful = require("beautiful")

local wibox = require("wibox")

local gears = require('gears')

local M = {}

M.sep = wibox.widget {
    {
        forced_height = 2,
        shape = gears.shape.line,
        widget = wibox.widget.separator,
    },
    widget = wibox.container.margin
}

M.clock = wibox.widget {
    font = beautiful.barfont,
    format = "%H\n%M",
    refresh = 1,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

return M
