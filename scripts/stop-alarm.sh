#!/bin/bash

kill -9 $(pgrep -f sunrise-alarm.py)
kill -9 $(pgrep -f control-volume.sh)
killall play