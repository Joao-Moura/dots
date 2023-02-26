local awful = require("awful")

local gears = require('gears')

local M = {}

local net = [[ nmcli -c no networking connectivity check ]]
M.net = function()
    awful.spawn.easy_async_with_shell(net, function(out)
        awesome.emit_signal('net::value', (out:match("full") or out:match("portal")) and 1 or 0)
    end)
end

local bat = [[ charge=$(acpi | awk -F' ' '{print $4}' | xargs | tr -d '[%,]'); printf "$(acpi | awk -F' ' '{print $3}' | xargs | tr -d '[,]') ${charge% *}\n" ]]
M.bat = function()
    awful.spawn.easy_async_with_shell(bat, function(out)
        local vars = gears.string.split(out, " ")
        awesome.emit_signal('bat::value', vars[1], tonumber(vars[2]))
    end)
end

local vol = [[ str=$( pactl get-sink-volume @DEFAULT_SINK@ | awk -F' ' '{print $5}' | xargs | tr -d '[%]' ); printf "$(pactl get-sink-mute @DEFAULT_SINK@ | awk -F' ' '{print $2}' | xargs) ${str% *}\n" ]]
M.vol = function()
    awful.spawn.easy_async_with_shell(vol, function(out)
        local vars = gears.string.split(out, " ")
        awesome.emit_signal('vol::value', vars[1]:match("sim") and 1 or 0, tonumber(vars[2]))
    end)
end

gears.timer {
    timeout = 20,
    call_now = true,
    autostart = true,
    callback = function()
        M.net()
        M.bat()
    end
}

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        M.vol()
    end
}

return M
