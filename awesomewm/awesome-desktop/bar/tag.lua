local awful = require("awful")

local beautiful = require("beautiful")

local wibox = require("wibox")

local update_tags = function(self, c3, index, objects)
    if c3.selected then
        self:get_children_by_id('background_widget')[1].fg = "#E8E3E3"
    elseif #c3:clients() > 0 then
        self:get_children_by_id('background_widget')[1].fg = "#A29D9D"
    else
        self:get_children_by_id('background_widget')[1].fg = "#484343"
    end

    self:get_children_by_id('text_widget')[1].text = c3.name
end

local get_taglist = function(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 15,
            layout = wibox.layout.fixed.horizontal,
        },
        style = {
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
                    id = 'text_widget',
                    widget = wibox.widget.textbox,
                    valign = 'center',
                    align = 'center',
                    font = beautiful.barfont
                },
                widget = wibox.container.margin,
            },
            id = 'background_widget',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects) update_tags(self, c3, index, objects) end,
            update_callback = function(self, c3, index, objects) update_tags(self, c3, index, objects) end,
        }
    }
end

return get_taglist
