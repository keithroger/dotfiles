local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- TODO add red color when low
-- TODO add icon instead of label

beautiful.init("/home/kro/.config/awesome/theme.lua")

local battery_widget = wibox.widget {
    {
        id = "battery_textbox",
        text = "BAT:",
        widget = wibox.widget.textbox,
    },
    {
        min_value = 0,
        max_value = 100,
        value = 90,
        paddings = 1,
        color = beautiful.bg_focus,
        background_color = beautiful.bg_normal,
        border_color = beautiful.bg_focus,
        border_width = 1,
        id = "batterybar",
        margins = 6,
        paddings = 2,
        forced_width = 44,
        bar_shape = gears.shape.rectangle,
        widget = wibox.widget.progressbar,
    },
    layout = wibox.layout.fixed.horizontal,
    set_value = function(self, val)
        self.batterybar.value = tonumber(val)
    end,
}

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function () 
        awful.spawn.easy_async(
            {"sh", "-c", "acpi -b | awk '{print $4}' | egrep -o '[0-9]+'"},
            function(out)
                battery_widget:set_value(out)
            end
        )
    end
}

return battery_widget
