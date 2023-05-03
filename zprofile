# User environment variables
export BROWSER=firefox # browser
export EDITOR=nvim # editor
export LANG=en_US.UTF-8 # language
export TERM=foot # terminal

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	# Wayland environment variables
	export QT_QPA_PLATFORM=wayland
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WEBRENDER=1
	export XDG_SESSION_TYPE=wayland
	export XDG_CURRENT_DESKTOP=sway

	# Start sway
	exec sway
fi
