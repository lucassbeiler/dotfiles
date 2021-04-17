#!/bin/sh
#xset +fp $HOME/.fonts
xset +fp /usr/share/fonts
xset fp rehash

if [ "$(cat /sys/class/drm/*HDMI*/status)" = "connected" ]; then
	xrandrArgs="--output eDP-1-1 --off"
fi

exec xrandr --setprovideroutputsource modesetting NVIDIA-0 &
exec xrandr --auto ${xrandrArgs} &
exec picom -b --experimental-backends &
exec dwmbar.sh &
exec clima.sh &
exec feh --no-fehbg --bg-fill '/home/lucas/Downloads/wallpaper.jpg' &
exec dwm



