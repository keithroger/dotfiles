local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- TODO add red color when high
-- TODO add icon instead of label

beautiful.init("/home/kro/.config/awesome/theme.lua")

local cpu_widget = wibox.widget {
    {
        id = "cpu_label",
        text = "CPU: ",
        widget = wibox.widget.textbox,
    },
    {
        id = "cpu_percent",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
}

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function () 
        awful.spawn.easy_async(
            {"sh", "-c", "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print int(($2+$4-u1) * 100 / (t-t1)); }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat) | awk '{ printf(\"%02d%\", $1) }' "},
            function(out)
                cpu_widget.cpu_percent.text = out
            end
        )
    end
}

return cpu_widget
