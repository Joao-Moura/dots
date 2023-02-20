local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'

local mod = require 'bindings.mod'

local menubar = require("menubar")

local terminal = "st"

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key(
        { mod.super, }, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    awful.key(
        { mod.super, }, "w",
        function ()
            mymainmenu:show()
        end,
        {description = "show main menu", group = "awesome"}
    ),
    awful.key(
        { mod.super, mod.ctrl }, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        { mod.super, mod.shift }, "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key(
        { mod.super, mod.shift }, "Return",
        function ()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        { mod.super }, "r",
        function ()
            awful.screen.focused().mypromptbox:run()
        end,
        {description = "run prompt", group = "launcher"}
    ),
    awful.key(
        { mod.super }, "p",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    ),
    awful.key(
        { mod.super, mod.shift }, "Right",
        function ()
            awful.spawn.with_shell("playerctl next")
        end,
        {description = "next music", group = "launcher"}
    ),
    awful.key(
        { mod.super, mod.shift }, "Left",
        function ()
            awful.spawn.with_shell("playerctl previous")
        end,
        {description = "previous music", group = "launcher"}
    ),
    awful.key(
        { mod.super, mod.shift }, "Up",
        function ()
            awful.spawn.with_shell("amixer -q sset Master 1%+")
            -- enviar signal do volume
        end,
        {description = "increase volume", group = "launcher"}
    ),
    awful.key(
        { mod.super, mod.shift }, "Down",
        function ()
            awful.spawn.with_shell("amixer -q sset Master 1%-")
            -- enviar signal do volume
        end,
        {description = "decrease volume", group = "launcher"}
    ),
    awful.key(
        {  }, "Print",
        function ()
            awful.spawn.with_shell("scrot -s /tmp/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'")
        end,
        {description = "take screenshot", group = "launcher"}
    ),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { mod.super, }, "Left",
        awful.tag.viewprev,
        {description = "view previous", group = "tag"}
    ),
    awful.key(
        { mod.super, }, "Right",
        awful.tag.viewnext,
        {description = "view next", group = "tag"}
    ),
    awful.key(
        { mod.super, }, "Tab",
        awful.tag.history.restore,
        {description = "go back", group = "tag"}
    ),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { mod.super, }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        { mod.super, }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
        { mod.super, mod.ctrl }, "j",
        function ()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        { mod.super, mod.ctrl }, "k",
        function ()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        { mod.super, mod.ctrl }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        {description = "restore minimized", group = "client"}
    ),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { mod.super, mod.shift }, "j",
        function ()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        { mod.super, mod.shift }, "k",
        function ()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        { mod.super, }, "space",
        function ()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        { mod.super, mod.shift }, "space",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod.super },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { mod.super, mod.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl, mod.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button(
            { }, 1,
            function (c)
                c:activate { context = "mouse_click" }
            end
        ),
        awful.button(
            { mod.super }, 1,
            function (c)
                c:activate { context = "mouse_click", action = "mouse_move"  }
            end
        ),
        awful.button(
            { mod.super }, 3,
            function (c)
                c:activate { context = "mouse_click", action = "mouse_resize"}
            end
        ),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key(
            { mod.super, }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}
        ),
        awful.key(
            { mod.super, mod.shift }, "c",
            function (c)
                c:kill()
            end,
            {description = "close", group = "client"}
        ),
        awful.key(
            { mod.super, mod.ctrl }, "space",
            awful.client.floating.toggle,
            {description = "toggle floating", group = "client"}
        ),
        awful.key(
            { mod.super, mod.ctrl }, "Return",
            function (c)
                c:swap(awful.client.getmaster())
            end,
            {description = "move to master", group = "client"}
        ),
        awful.key(
            { mod.super, }, "o",
            function (c)
                c:move_to_screen()
            end,
            {description = "move to screen", group = "client"}
        ),
        awful.key(
            { mod.super, }, "t",
            function (c)
                c.ontop = not c.ontop
            end,
            {description = "toggle keep on top", group = "client"}
        ),
        awful.key(
            { mod.super, }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            {description = "minimize", group = "client"}
        ),
        awful.key(
            { mod.super, }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize", group = "client"}
        ),
        awful.key(
            { mod.super, mod.ctrl }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            {description = "(un)maximize vertically", group = "client"}
        ),
        awful.key(
            { mod.super, mod.shift }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            {description = "(un)maximize horizontally", group = "client"}
        ),
    })
end)
