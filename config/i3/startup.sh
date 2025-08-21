#!/bin/zsh

# Get the connected monitors and place it in array
SCR=($(xrandr | awk '/ connected/ {print $1}'))
DELAY=0.5


if [ -n "${SCR[1]}" ]; then
    i3-msg "workspace 1; move workspace to output ${SCR[1]}; exec alacritty"
    sleep $DELAY
    i3-msg "workspace 2; move workspace to output ${SCR[1]}; exec alacritty"
    sleep $DELAY
    i3-msg "workspace 6; move workspace to output ${SCR[2]}; exec firefox --private-window"
    sleep $DELAY
    i3-msg "workspace 7; move workspace to output ${SCR[2]}; exec pavucontrol"
    sleep $DELAY
    i3-msg "workspace 8; move workspace to output ${SCR[2]}; exec firefox --profile ~/.mozilla/firefox/8nmzib4l.default-release"
    sleep 2
    i3-msg "workspace 9; move workspace to output ${SCR[2]}; exec chromium"
    sleep 2
    i3-msg "workspace 10; move workspace to output ${SCR[2]}; exec slack"
    sleep $DELAY
	# Portrait
	#xrandr --output HDMI-1 --rotate left
else
    # add sigle screen setup
    echo "NO second monitor"
fi
