#!/bin/sh
#xset +fp $HOME/.fonts
xset +fp /usr/share/fonts
xset fp rehash


exec setxkbmap us -variant alt-intl &
exec $HOME/.config/dwm/clima.sh &
exec $HOME/.config/dwm/dwmbar.sh &
exec $HOME/dwm-6.2/dwm
