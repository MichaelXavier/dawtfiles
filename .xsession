xset r rate 175 35
setxkbmap -option terminate:ctrl_alt_bksp
# bind caps lock to esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
