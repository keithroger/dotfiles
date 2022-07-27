local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

beautiful.init("/home/kro/.config/awesome/theme.lua")

local spotify_widget = wibox.widget {
    {
        id = "widget_text",
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
            -- {"sh", "-c", "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print int(($2+$4-u1) * 100 / (t-t1)); }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat) | awk '{ printf(\"%02d%\", $1) }' "},
            {"sh", "-c", "sp current"},
            function(out)
                if string.find(out, 'Error: Spotify is not running.') ~= nil then
                    spotify_widget.widget_text.text = ''
                end

                local escaped = string.gsub(out, "&", '&amp;')
                local _, _, artist, title =
                    string.match(escaped, 'Album%s*(.*)\nAlbumArtist%s*(.*)\nArtist%s*(.*)\nTitle%s*(.*)\n')

                if title ~=nil and artist ~= nil then
                    spotify_widget.widget_text.text = artist..' - '..title
                end
            end
        )
    end
}

return spotify_widget
