#!/bin/sh

dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP DESKTOP_SESSION

eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL SSH_AUTH_SOCK

xrdb -merge "$HOME/.Xresources"

xset r rate 300 50

xrandr --dpi 144
xrandr --output eDP --mode 2880x1800 --rate 120

~/.fehbg &
xsettingsd -c ~/.xsettingsd &

exec i3
