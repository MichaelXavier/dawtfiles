xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
numlockx &
# set up fonts dir
xset +fp /usr/share/fonts/local
xset fp rehash

# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
numlockx &
xset r rate 175 35
xflux -z 98021
~/.screenlayout/layout.sh
/usr/bin/xscreensaver -no-splash &
exec startlxde
