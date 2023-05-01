---@diagnostic disable-next-line: undefined-global
local client = client

pcall(require, "luarocks.loader")

local theme = require("theme")
local beautiful = require("beautiful")

beautiful.init(theme)

require("notifications") -- Setup error handling
require("awful.autofocus") -- Setup autofocus
require("awful.hotkeys_popup.keys")
require("keys") -- key and mouse bindings
require("rules")
require("bar")
require("autostart")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)

-- dont maximize client automatically
client.connect_signal("request::manage", function(c)
  c.maximized = false
  c.maximized_horizontal = false
  c.maximized_vertical = false
  -- make floating windows always ontop
  if c.floating then c.ontop = true end
end)

---@diagnostic disable-next-line: param-type-mismatch
collectgarbage("setpause", 110)
---@diagnostic disable-next-line: param-type-mismatch
collectgarbage("setstepmul", 1000)

