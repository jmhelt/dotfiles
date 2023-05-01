---@diagnostic disable-next-line: undefined-global
local awesome = awesome

local awful = require("awful")
local beautiful = require("beautiful")
local helper = require("helper")
local pallete = require("theme.pallete")
local wibox = require("wibox.init")

local dpi = beautiful.xresources.apply_dpi

local date = wibox.widget.textclock(
    string.format(
        "<span font='%s' color='%s'>   </span><span font='%s' color='%s'>%%a, %%b %%d </span>",
        beautiful.icon_font .. " " .. beautiful.font_size,
        pallete.brightblue,
        beautiful.font_alt .. " Bold " .. beautiful.font_size,
        pallete.foreground
    )
)

local date_boxed = helper.box_widget({
    widget = date,
    bg_color = beautiful.module_bg,
    margins = dpi(6),
    horizontal_padding = dpi(12),
})

helper.hover({
    widget = date_boxed:get_children_by_id("box_container")[1],
    oldbg = beautiful.module_bg,
    newbg = beautiful.module_bg_focused,
})

date_boxed:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        awesome.emit_signal("calendar::toggle", awful.screen.focused())
    end
end)

return date_boxed
