#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

# Path to alarm.json
ALARM_FILE="$SCRIPT_DIR/../alarm.json"

# Read alarm.json file and parse the time and enabled status
ALARM_TIME=$(jq -r '.alarmTime' "$ALARM_FILE")
ALARM_ENABLED=$(jq -r '.alarmEnabled' "$ALARM_FILE")

# Get the current time in HH:MM format
CURRENT_TIME=$(date +"%H:%M")

# Check if the alarm is enabled and the current time matches alarmTime
if [[ "$ALARM_ENABLED" == "true" && "$CURRENT_TIME" == "$ALARM_TIME" ]]; then
    echo "Alarm time reached! Running the commands..."
    ./$SCRIPT_DIR/check-alarm.sh &
else
    echo "No alarm triggered. Current time is $CURRENT_TIME. Alarm time is $ALARM_TIME. The alarm status is $ALARM_ENABLED"
fi