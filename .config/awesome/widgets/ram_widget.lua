local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- TODO add red color when high
-- TODO add icon instead of label

beautiful.init("/home/kro/.config/awesome/theme.lua")

local ram_widget = wibox.widget {
    {
        id = "ram_label",
        text = "RAM: ",
        widget = wibox.widget.textbox,
    },
    {
        id = "ram_percent",
        widget = wibox.widget.textbox,
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
            {"sh", "-c", "free | awk '/^Mem/ { a=(($3)/$2 * 100); print int(a)\"%\" }'"},
            function(out)
                ram_widget.ram_percent.text = out
            end
        )
    end
}

return ram_widget
