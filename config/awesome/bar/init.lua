---@diagnostic disable-next-line: undefined-global
local tag = tag

local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal(
  "request::default_layouts",
  function()
    awful.layout.append_default_layouts({
      awful.layout.suit.tile,
      awful.layout.suit.floating,
    })
  end
)

--      ────────────────────────────────────────────────────────────

local volume = require("bar.modules.volume")
local layout = require("bar.modules.layoutbox")
local date = require("bar.modules.date")
local time = require("bar.modules.time")
local systray = require("bar.modules.systray")
local taglist = require("bar.modules.taglist")
local tasklist = require("bar.modules.tasklist")
local button = require("bar.modules.button")
local mpd = require("bar.modules.mpd")
local redshift = require("bar.modules.redshift")

--      ────────────────────────────────────────────────────────────

---@diagnostic disable-next-line: undefined-global
screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "Main", "Music", "Social", "Dev" }, s, awful.layout.layouts[1])

  s.calendar = require("bar.modules.calendar").setup(s)
  s.dashboard = require("bar.modules.button.dashboard").setup(s)
  s.music_panel = require("bar.modules.mpd.popup").setup(s)

  awful.wallpaper({
    screen = s,
    widget = {
      {
        image = beautiful.wallpaper,
        resize = true,
        widget = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled = false,
      widget = wibox.container.tile,
    },
  })

  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(32),
    widget = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        layout(s),
        taglist(s),
        tasklist(s),
      },
      { -- Middle widget
        layout = wibox.layout.flex.horizontal,
        mpd,
      },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        systray,
        redshift,
        volume,
        date,
        time,
        button,
      },
    },
  })
end)
