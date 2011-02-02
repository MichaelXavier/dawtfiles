xsetroot -cursor_name left_ptr
setxkbmap -option terminate:ctrl_alt_bksp
xcompmgr &
numlockx &
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Control = Control_L"
numlockx &
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Control = Control_L"
exec ck-launch-session startlxde
