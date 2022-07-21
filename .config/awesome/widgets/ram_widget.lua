local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- TODO add red color when high
-- TODO add icon instead of label

local ram_widget = wibox.widget {
    {
        id = "ram_textbox",
        text = "RAM:",
        widget = wibox.widget.textbox,
    },
    {
        min_value = 0,
        max_value = 100,
        value = 90,
        paddings = 1,
        color = "#333",
        background_color = "#999",
        id = "rambar",
        margins = 6,
        paddings = 2,
        forced_width = 44,
        bar_shape = gears.shape.rectangle,
        widget = wibox.widget.progressbar,
    },
    layout = wibox.layout.fixed.horizontal,
    set_value = function(self, val)
        self.rambar.value = tonumber(val)
    end,
}

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function () 
        awful.spawn.easy_async(
            {"sh", "-c", "free | awk '/^Mem/ { a=(($3)/$2 * 100); print a }'"},
            function(out)
                ram_widget:set_value(out)
            end
        )
    end
}

return ram_widget
