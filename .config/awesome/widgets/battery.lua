local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- TODO add red color when low
-- TODO add icon instead of label

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
        color = "#333",
        background_color = "#999",
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
            {"sh", "-c", "acpi -b | awk '{print substr($4, 1, length($4)-2)}'"},
            function(out)
                battery_widget:set_value(out)
            end
        )
    end
}

return battery_widget
