local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- TODO add red color when low
-- TODO add icon instead of label

beautiful.init("/home/kro/.config/awesome/theme.lua")

local battery_widget = wibox.widget {
    {
        id = "battery_label",
        text = "BAT: ",
        widget = wibox.widget.textbox,
    },
    {
        id = "battery_percent",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
}

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function () 
        awful.spawn.easy_async(
            -- {"sh", "-c", "acpi -b | egrep -o '[0-9]+%' | awk '{print substr($1, 1, length($1)-1)}'"},
            {"sh", "-c", "acpi -b | egrep -o '[0-9]+%' "},
            function(out)
                battery_widget.battery_percent.text = out
            end
        )
    end
}

return battery_widget
