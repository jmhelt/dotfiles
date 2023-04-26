local awesome, client, screen = awesome, client, screen
local string, os, tostring, type = string, os, tostring, type

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus") -- Setup autofocus
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 75

local lain        = require("lain")
local freedesktop = require("freedesktop")
local settings    = require("settings")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Setup error handling
require("error-handling").setup()

-- awesome variables
awful.util.terminal = settings.terminal
awful.util.tagnames = { " Main ", " Music ", " Social ", " Dev " }
--awful.layout.suit.tile.left.mirror = true

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.floating,
  --awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
  --awful.layout.suit.max,
  --awful.layout.suit.max.fullscreen,
  --awful.layout.suit.magnifier,
  --awful.layout.suit.corner.nw,
  --awful.layout.suit.corner.ne,
  --awful.layout.suit.corner.sw,
  --awful.layout.suit.corner.se,
  --lain.layout.cascade,
  --lain.layout.cascade.tile,
  --lain.layout.centerwork,
  --lain.layout.centerwork.horizontal,
  --lain.layout.termfair,
  --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ settings.modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ settings.modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    local instance = nil

    return function()
      if instance and instance.wibox.visible then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({ theme = { width = 250 } })
      end
    end
  end),
  awful.button({}, 4, function() awful.client.focus.byidx(1) end),
  awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/%s.lua",
  settings.chosen_theme, settings.chosen_theme))

local myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end },
  { "manual", settings.terminal .. " -e 'man awesome'" },
  { "edit config", settings.terminal .. " -e " .. settings.editor .. " " .. awesome.conffile },
  { "restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
  icon_size = beautiful.menu_height or 16,
  before = {
    { "Awesome", myawesomemenu, beautiful.awesome_icon },
    --{ "Atom", "atom" },
    -- other triads can be put here
  },
  after = {
    { "Terminal", settings.terminal },
    { "Log out", function() awesome.quit() end },
    { "Sleep", "systemctl suspend" },
    { "Restart", "systemctl reboot" },
    { "Shutdown", "systemctl poweroff" },
    -- other triads can be put here
  }
})

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

root.buttons(my_table.join(
  awful.button({}, 3, function() awful.util.mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

globalkeys = my_table.join(

  -- Hotkeys Awesome

  awful.key({ settings.modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),

  -- Tag browsing with modkey
  awful.key({ settings.modkey, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ settings.modkey, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ settings.altkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  -- Tag browsing alt + tab
  awful.key({ settings.altkey, }, "Tab", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ settings.altkey, "Shift" }, "Tab", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),

  -- Tag browsing modkey + tab
  awful.key({ settings.modkey, }, "Tab", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ settings.modkey, "Shift" }, "Tab", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),


  -- Default client focus
  awful.key({ settings.altkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ settings.altkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),

  -- By direction client focus
  awful.key({ settings.modkey }, "j",
    function()
      awful.client.focus.global_bydirection("down")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus down", group = "client" }),
  awful.key({ settings.modkey }, "k",
    function()
      awful.client.focus.global_bydirection("up")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus up", group = "client" }),
  awful.key({ settings.modkey }, "h",
    function()
      awful.client.focus.global_bydirection("left")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus left", group = "client" }),
  awful.key({ settings.modkey }, "l",
    function()
      awful.client.focus.global_bydirection("right")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus right", group = "client" }),


  -- By direction client focus with arrows
  awful.key({ settings.modkey1, settings.modkey }, "Down",
    function()
      awful.client.focus.global_bydirection("down")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus down", group = "client" }),
  awful.key({ settings.modkey1, settings.modkey }, "Up",
    function()
      awful.client.focus.global_bydirection("up")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus up", group = "client" }),
  awful.key({ settings.modkey1, settings.modkey }, "Left",
    function()
      awful.client.focus.global_bydirection("left")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus left", group = "client" }),
  awful.key({ settings.modkey1, settings.modkey }, "Right",
    function()
      awful.client.focus.global_bydirection("right")
      if client.focus then client.focus:raise() end
    end,
    { description = "focus right", group = "client" }),



  awful.key({ settings.modkey, }, "w", function() awful.util.mymainmenu:show() end,
    { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  awful.key({ settings.modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ settings.modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ settings.modkey }, ".", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ settings.modkey }, ",", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ settings.modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ settings.modkey1, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- Show/Hide Wibox
  awful.key({ settings.modkey }, "b", function()
    for s in screen do
      s.mywibox.visible = not s.mywibox.visible
      if s.mybottomwibox then
        s.mybottomwibox.visible = not s.mybottomwibox.visible
      end
    end
  end,
    { description = "toggle wibox", group = "awesome" }),

  -- Standard program
  awful.key({ settings.modkey, }, "Return", function() awful.spawn(settings.terminal) end,
    { description = "terminal", group = "super" }),
  awful.key({ settings.modkey }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ settings.modkey, "Shift" }, "q",
    function() awful.spawn.with_shell('~/.dmenu/prompt "are you sure?" "killall awesome"') end,
    { description = "quit awesome", group = "awesome" }),

  awful.key({ settings.altkey, "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ settings.altkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ settings.modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ settings.modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ settings.modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ settings.modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ settings.modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),

  awful.key({ settings.modkey, }, "`", function() awful.util.spawn("rofi -show") end,
    { description = "Run Rofi", group = "launcher" }),

  awful.key({ settings.modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Widgets popups
  awful.key({ settings.altkey, }, "c", function() beautiful.cal.show(7) end,
    { description = "show calendar", group = "widgets" }),
  awful.key({ settings.altkey, }, "h", function() if beautiful.fs then beautiful.fs.show(7) end end,
    { description = "show filesystem", group = "widgets" }),
  awful.key({ settings.altkey, }, "w", function() if beautiful.weather then beautiful.weather.show(7) end end,
    { description = "show weather", group = "widgets" }),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function() os.execute("xbacklight -inc 10") end,
    { description = "+10%", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", function() os.execute("xbacklight -dec 10") end,
    { description = "-10%", group = "hotkeys" }),

  -- Pulseaudio volume control
  -- Volume Keys
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      os.execute("pamixer -i 10")
      beautiful.volume.update()
    end),
  awful.key({}, "XF86AudioLowerVolume",
    function()
      os.execute("pamixer -d 10")
      beautiful.volume.update()
    end),
  awful.key({}, "XF86AudioMute",
    function()
      os.execute("pamixer -t")
      beautiful.volume.update()
    end),

  -- Media Keys
  awful.key({}, "XF86AudioPlay", function()
    awful.util.spawn("playerctl play-pause", false)
  end),
  awful.key({}, "XF86AudioNext", function()
    awful.util.spawn("playerctl next", false)
  end),
  awful.key({}, "XF86AudioPrev", function()
    awful.util.spawn("playerctl previous", false)
  end),

  awful.key({ settings.altkey, "Shift" }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }))

clientkeys = my_table.join(
  awful.key({ settings.altkey, "Shift" }, "m", lain.util.magnify_client,
    { description = "magnify client", group = "client" }),
  awful.key({ settings.modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ settings.modkey, }, "q", function(c) c:kill() end,
    { description = "close", group = "hotkeys" }),
  awful.key({ settings.modkey, "Shift" }, "space", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ settings.modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ settings.modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ settings.modkey, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  awful.key({ settings.modkey, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),
  awful.key({ settings.modkey, }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = { description = "view tag #", group = "tag" }
    descr_toggle = { description = "toggle tag #", group = "tag" }
    descr_move = { description = "move focused client to tag #", group = "tag" }
    descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
  end
  globalkeys = my_table.join(globalkeys,
    -- View tag only.
    awful.key({ settings.modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view),
    -- Toggle tag display.
    awful.key({ settings.modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle),
    -- Move client to tag.
    awful.key({ settings.modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move),
    -- Toggle tag on focused client.
    awful.key({ settings.modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus)
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ settings.modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ settings.modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },

  -- Titlebars
  { rule_any = { type = { "dialog", "normal" } },
    properties = { titlebars_enabled = settings.enableTitlebar } },

}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and
    not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- Custom
  if beautiful.titlebar_fun then
    beautiful.titlebar_fun(c)
    return
  end

  -- Default
  -- buttons for the titlebar
  local buttons = my_table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c, { size = 21 }):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

if (settings.focusOnHover == true)
then
  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = true })
  end)
end

-- No border for maximized clients
function border_adjust(c)
  if c.maximized then -- no borders if only 1 client visible
    c.border_width = 0
  elseif #awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Auto-run background processes
local function run_once(cmd)
  local pname = cmd
  local first_space = cmd:find(" ")
  if first_space then
    pname = cmd:sub(0, first_space-1)
  end
  cmd = string.format("pgrep -u $USER -x %s > /dev/null || (%s)", pname, cmd)
  awful.spawn.with_shell(cmd)
end

if (settings.use_nitrogen == true) then
  run_once("nitrogen --restore")
end

if (settings.use_picom == true) then
  run_once("picom -b")
end

if (settings.use_nmapplet == true) then
  run_once("nm-applet")
end

-- Policy kit is an essential tool for managing privileges and permission,
-- we are using lxpolkit for this matter, if you wish to use a different polkit install and change the directory here
if (settings.use_lxpolkit == true) then
  run_once("lxpolkit")
end

if (settings.use_flameshot == true) then
  run_once("flameshot")
end
