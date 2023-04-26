local settings = {}


---------- Theme ----------
settings.themes = {
    "PowerArrow_Neon", -- 1
    "PowerArrow_Genesis", -- 2
    "PowerArrow_Matcha", -- 3
    "PowerArrow_RGB", -- 4
    "PowerArrow_CalmRed" -- 5
}

settings.chosen_theme = settings.themes[2] -- replace number inside of [] with a theme number from the list above

settings.enableTitlebar = false -- Set to true if you wish to have title bars on top of applications (i.e to have buttons: close, minimise, etc )

settings.gap_size = 10 -- set your gap size here

settings.focusOnHover = true -- set to false if you don't want the window to focused on mouse hover

---------- Startup Programs ----------

-- Required package: nitrogen
settings.use_nitrogen = false -- Set this to true for nitrogen to do your wallpaper (if you want to use the theme's default wallpaper set this to false)

-- Required Package: picom
settings.use_picom = true -- Set this to true if you want picom to launch on startup

-- Requires network manager
settings.use_nmapplet = true -- If you have network manager installed, you can use manage your network (i.e connect to wifi) from the system tray icon

-- Required Package: lxpolkit
settings.use_lxpolkit = true -- If you would like to use a polkit (without one you can't easily install applications from the store or make changes to partitions for example), you can set this to true

-- Required Package: flameshot
settings.use_flameshot = false -- If you want flameshot (screenshotting tool) to auto start


---------- Get your local weather ID from https://openweathermap.org/ ----------

settings.weatherID = 5102922 -- Set this to your own weather ID


---------- User settings ----------

settings.terminal = "kitty"

settings.editor = "nvim"

settings.modkey  = "Mod4"
settings.altkey  = "Mod1"
settings.modkey1 = "Control"



return settings
