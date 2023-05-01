local beautiful = require("beautiful")
local helper = require("helper")
local pallete = require("theme.pallete")
local wibox = require("wibox.init")

local dpi = beautiful.xresources.apply_dpi

local time = wibox.widget.textclock(
    string.format(
        "<span font='%s' color='%s'>   </span><span font='%s' color='%s'>%%I:%%M %%p </span>",
        beautiful.icon_font .. " " .. beautiful.font_size,
        pallete.brightblue,
        beautiful.font_alt .. " Bold " .. beautiful.font_size,
        pallete.foreground
    )
)

local time_boxed = helper.box_widget({
    widget = time,
    bg_color = beautiful.module_bg,
    margins = dpi(6),
    horizontal_padding = dpi(12),
})

return time_boxed
