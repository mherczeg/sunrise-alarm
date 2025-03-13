#!/bin/bash

# Load environment variables from the .env file located one level above the current directory
source "$(dirname "$0")/../.env"

SCRIPT_DIR=$(dirname "$0")

# Path to alarm.json
ALARM_FILE="$SCRIPT_DIR/../alarm.json"

# Read alarm.json file and parse the time and enabled status
ALARM_TIME=$(jq -r '.alarmTime' "$ALARM_FILE")
ALARM_ENABLED=$(jq -r '.alarmEnabled' "$ALARM_FILE")

# Get the current time in HH:MM format
END_TIME=$(date -d "+$SUNRISE_DURATION minutes" +"%H:%M")

Check if the alarm is enabled and the alarm end time matches alarmTime
if [[ "$ALARM_ENABLED" == "true" && "$ALARM_TIME" == "$END_TIME" ]]; then
    echo "Alarm time reached! Running the commands..."
    source "$SCRIPT_DIR/start-alarm.sh"
else
    echo "No alarm triggered. The alarm end time would be $END_TIME. Alarm time is $ALARM_TIME. The alarm status is $ALARM_ENABLED"
fi