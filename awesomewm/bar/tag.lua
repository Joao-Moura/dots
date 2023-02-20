local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local get_taglist = function(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout  = {
            spacing = 5,
            layout = wibox.layout.fixed.vertical,
        },
        style   = {
            font = beautiful.barfont,
        },
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
        widget_template = {
            {
                {
                    id = 'my_text_role',
                    widget = wibox.widget.textbox,
                    valign = 'center',
                    align = 'center',
                    font = beautiful.barfont
                },
                widget = wibox.container.margin,
            },
            id = 'my_back_role',
            widget = wibox.container.background,
            update_callback = function(self, c3, index, objects)
                if c3.selected then
                    self:get_children_by_id('my_back_role')[1].fg = "#FFFFFF"
                else
                    self:get_children_by_id('my_back_role')[1].fg = beautiful.fg
                end

                if #c3:clients() > 0 or c3.selected then
                    self:get_children_by_id('my_text_role')[1].text = c3.name
                else
                    self:get_children_by_id('my_text_role')[1].markup = ""
                end
            end
        }
    }
end

return get_taglist
