#!/usr/bin/env bash

# Terminate running bar
killall -q polybar

# Launch bar
polybar top >>/tmp/toppolybar.log 2>&1 &

echo "Polybar launched..."
