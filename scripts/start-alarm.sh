#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

python3 $SCRIPT_DIR/../sunrise-alarm.py&
(play -q $SCRIPT_DIR/../sounds/bird-30mins.mp3)&
./$SCRIPT_DIR/control-volume.sh &