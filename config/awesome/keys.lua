---@diagnostic disable-next-line: undefined-global
local awesome, client = awesome, client

local awful = require("awful.init")
local hotkeys_popup = require("awful.hotkeys_popup")
local settings = require("settings")

awful.mouse.append_global_mousebindings({
	awful.button({}, 3, function() end),
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	awful.key(
		{	settings.modkey },
		"F1",
		hotkeys_popup.show_help,
		{ description = "show help", group = "awesome" }
	),

	awful.key(
		{ settings.modkey, "Shift" },
		"r",
		awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),

	awful.key(
		{ settings.modkey },
		"Return",
		function() awful.spawn(settings.terminal) end,
		{ description = "open a settings.terminal", group = "launcher" }
	),

	awful.key(
		{ "Mod1" },
		"space",
		function() awful.spawn("rofi -show drun") end,
		{ description = "Rofi", group = "launcher" }
	),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
	awful.key(
		{ settings.modkey, "Shift" },
		"Tab",
		awful.tag.viewprev,
		{ description = "view previous", group = "tag" }
	),

	awful.key(
		{ settings.modkey },
		"Tab",
		awful.tag.viewnext, { description = "view next", group = "tag" }
	),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	awful.key(
		{ settings.modkey },
		"j",
		function() awful.client.focus.bydirection("down", client.focused) end,
		{ description = "focus by direction down", group = "client" }
	),

	awful.key(
		{ settings.modkey },
		"k",
		function() awful.client.focus.bydirection("up", client.focused) end,
		{ description = "focus by direction up", group = "client" }
	),

	awful.key(
		{ settings.modkey },
		"h",
		function() awful.client.focus.bydirection("left", client.focused) end,
		{ description = "focus by direction left", group = "client" }
	),

	awful.key(
		{ settings.modkey },
		"l",
		function() awful.client.focus.bydirection("right", client.focused) end,
		{ description = "focus by direction down", group = "client" }
	),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
	awful.key(
		{ settings.modkey, "Shift" },
		"j",
		function() awful.client.swap.bydirection("down", client.focused) end,
		{ description = "swap by direction down", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Shift" },
		"k",
		function() awful.client.swap.bydirection("up", client.focused) end,
		{ description = "swap by direction up", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Shift" },
		"h",
		function() awful.client.swap.bydirection("left", client.focused) end,
		{ description = "swap by direction left", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Shift" },
		"l",
		function() awful.client.swap.bydirection("right", client.focused) end,
		{ description = "swap by direction right", group = "client" }
	),

	awful.key({ settings.modkey },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),

	awful.key(
		{ settings.modkey },
		"space",
		function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }
	),

	awful.key(
		{ settings.modkey, "Shift" },
		"space",
		function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }
	),

	awful.key(
		{ settings.modkey, "Control" },
		"k",
		function() awful.client.incwfact(-0.05) end,
		{ description = "Resize by direction up", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Control" },
		"j",
		function() awful.client.incwfact(0.05) end,
		{ description = "Resize by direction down", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Control" },
		"h",
		function() awful.tag.incmwfact(-0.05) end,
		{ description = "Resize by direction left", group = "client" }
	),

	awful.key(
		{ settings.modkey, "Control" },
		"l",
		function() awful.tag.incmwfact(0.05) end,
		{ description = "Resize by direction right", group = "client" }
	),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { settings.modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then tag:view_only() end
		end,
	}),
	awful.key({
		modifiers = { settings.modkey, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then awful.tag.viewtoggle(tag) end
		end,
	}),
	awful.key({
		modifiers = { settings.modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then client.focus:move_to_tag(tag) end
			end
		end,
	}),
})

-- Brightness keys
awful.keyboard.append_global_keybindings({
	awful.key(
		{},
		"XF86MonBrightnessUp", function() os.execute("xbacklight -inc 10") end,
		{ description = "+10%", group = "hotkeys" }
	),
	awful.key(
		{},
		"XF86MonBrightnessDown",
		function() os.execute("xbacklight -dec 10") end,
		{ description = "-10%", group = "hotkeys" }
	),
})

-- Volume Keys with pulaseaudio
awful.keyboard.append_global_keybindings({
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		function() os.execute("pamixer -i 10") end
	),
	awful.key(
		{},
		"XF86AudioLowerVolume",
		function() os.execute("pamixer -d 10") end
	),
	awful.key(
		{},
		"XF86AudioMute",
		function() os.execute("pamixer -t") end
	),
})

-- Media Keys
awful.keyboard.append_global_keybindings({
	awful.key(
		{},
		"XF86AudioPlay",
		function() awful.util.spawn("playerctl play-pause", false) end
	),
	awful.key(
		{},
		"XF86AudioNext",
		function() awful.util.spawn("playerctl next", false) end
	),
	awful.key(
		{},
		"XF86AudioPrev",
		function() awful.util.spawn("playerctl previous", false) end
	),
})

--      ────────────────────────────────────────────────────────────

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button(
			{},
			1,
			function(c) c:activate({ context = "mouse_click" }) end
		),
		awful.button(
			{ settings.modkey },
			1,
			function(c)
				c:activate({ context = "mouse_click", action = "mouse_move" })
			end
		),
		awful.button(
			{ settings.modkey },
			3,
			function(c)
				c:activate({ context = "mouse_click", action = "mouse_resize" })
			end
		),
	})
end)

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key(
			{ settings.modkey },
			"f",
			function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{ description = "toggle fullscreen", group = "client" }
		),

		awful.key(
			{ settings.modkey },
			"q",
			function(c) c:kill() end,
			{ description = "close", group = "client" }
		),

		awful.key(
			{ settings.modkey },
			"t",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),

		--awful.key(
		--	{ settings.modkey },
		--	"t",
		--	function(c) c.ontop = not c.ontop end,
		--	{ description = "toggle keep on top", group = "client" }
		--),
	})
end)

