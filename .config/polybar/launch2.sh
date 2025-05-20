#!/bin/bash

killall -q polybar
polybar -c ~/.config/polybar/config2.ini example 2>&1 | tee -a /tmp/polybar.log & disown
