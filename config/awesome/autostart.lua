local awful = require("awful")
local settings = require("settings")

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

-- Start music player daemon
run_once("mpd")

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

