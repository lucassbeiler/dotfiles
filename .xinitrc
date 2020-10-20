#!/bin/sh
#xset +fp $HOME/.fonts
xset +fp /usr/share/fonts
xset fp rehash


exec setxkbmap us -variant alt-intl &

exec xrandr --setprovideroutputsource modesetting NVIDIA-0 &
exec xrandr --auto --output eDP-1-1 --off &

exec picom -b --experimental-backends &

exec $HOME/.config/dwm/clima.sh &
exec $HOME/.config/dwm/dwmbar.sh &

exec ~/.fehbg &

exec $HOME/dwm-6.2/dwm
