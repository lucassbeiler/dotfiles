#!/bin/sh
#xset +fp $HOME/.fonts
xset +fp /usr/share/fonts
xset fp rehash


exec xrandr --setprovideroutputsource modesetting NVIDIA-0 &
exec xrandr --auto --output eDP-1-1 --off &
exec picom -b --experimental-backends &
exec dwmbar.sh &
exec clima.sh &
exec feh --no-fehbg --bg-fill '/home/lucas/Downloads/wallpaper.jpg' &
exec dwm



