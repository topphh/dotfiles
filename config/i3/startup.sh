#!/bin/zsh
# Launch startup apps. Workspace placement is handled by the
# `workspace ... output` and `assign` rules in the i3 config, so
# everything starts in parallel with no sleeps.

run() { setsid -f "$@" >/dev/null 2>&1 }

# run alacritty --class startup-term1,Alacritty
# run alacritty --class startup-term2,Alacritty
run pavucontrol
run firefox --profile ~/.mozilla/firefox/8nmzib4l.default-release
run chromium
run slack

# run firefox --private-window   # ws6 (disabled)
# Portrait: xrandr --output HDMI-1 --rotate left
