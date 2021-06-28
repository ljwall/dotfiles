#xrandr --setprovideroutputsource modesetting NVIVIA-0
xrandr --output LVDS-1 --auto --primary --output DP-1-1 --auto --right-of LVDS-1
xrandr --dpi 96

setxkbmap -option caps:ctrl_modifier
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

~/.fehbg

xcompmgr -c &
systemctl --user set-environment DISPLAY=:0

xbindkeys

xautolock -time 5 -locker slock &

# exec xmonad-stack-exe
exec xmonad
# exec xfwm4
# exec awesome

