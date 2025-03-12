#!/bin/bash

echo "Starting volume control loop..."

# Load environment variables from the .env file located one level above the current directory
source "$(dirname "$0")/../.env"

# Set initial volume to 0
amixer -q set "$VOLUME_CONTROL" 0%

# Duration to gradually increase volume (20 minutes)
DURATION=$((SUNRISE_DURATION * 60))  # Convert minutes to seconds

TARGET_VOLUME=$SOUND_END_VOLUME
INITIAL_VOLUME=$SOUND_START_VOLUME

# Number of steps for gradual increase
STEPS=TARGET_VOLUME-INITIAL_VOLUME

# Calculate time interval for each step (in seconds)
STEP_INTERVAL=$((DURATION / STEPS))

# Gradually increase the volume from 0% to 50%
for ((i=INITIAL_VOLUME; i<=TARGET_VOLUME; i++)); do
    # Set the volume using amixer
    amixer set -q "$VOLUME_CONTROL" "${i}%"

    # Wait for the next step interval
    sleep $STEP_INTERVAL
done

# Set the to final volume
amixer set -q "$VOLUME_CONTROL" "$SOUND_WAKEUP_VOLUME%"
