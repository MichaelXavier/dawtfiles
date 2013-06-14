xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
numlockx &
dunst &
xset r rate 175 35
xset +fp /usr/share/fonts/local
xset fp rehash
xflux -z 98021
exec ck-launch-session startlxde
