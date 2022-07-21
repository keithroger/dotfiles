local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- TODO add red color when high
-- TODO add icon instead of label

local cpu_widget = wibox.widget {
    {
        id = "cpu_textbox",
        text = "CPU:",
        widget = wibox.widget.textbox,
    },
    {
        min_value = 0,
        max_value = 100,
        value = 90,
        paddings = 1,
        color = "#333",
        background_color = "#999",
        id = "cpubar",
        margins = 6,
        paddings = 2,
        forced_width = 44,
        bar_shape = gears.shape.rectangle,
        widget = wibox.widget.progressbar,
    },
    layout = wibox.layout.fixed.horizontal,
    set_value = function(self, val)
        self.cpubar.value = tonumber(val)
    end,
}

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function () 
        awful.spawn.easy_async(
            {"sh", "-c", "mpstat | awk 'END{print 100-$NF}'"},
            function(out)
                cpu_widget:set_value(out)
            end
        )
    end
}

return cpu_widget
