xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Control = Control_L"
numlockx &
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
xset +fp /usr/share/fonts/local
xset fp rehash
exec ck-launch-session startlxde
