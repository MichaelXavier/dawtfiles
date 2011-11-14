xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
numlockx &
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Control = Control_L"
numlockx &
xset r rate 175 35
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
exec ck-launch-session startlxde
