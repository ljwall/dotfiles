xrandr  --setprovideroutputsource modesetting NVIVIA-0
xrandr --output LVDS-1-1 --auto --primary --output DP-0 --auto --right-of LVDS-1-1

setxkbmap -option caps:ctrl_modifier
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

~/.fehbg

export PATH="${PATH}:~/bin"
xcompmgr -c &
systemctl --user set-environment DISPLAY=:0

xbindkeys

exec xmonad
# exec xfwm4

