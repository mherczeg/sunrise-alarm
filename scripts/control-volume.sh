#!/bin/bash

echo "Starting volume control loop..."

# Load environment variables from the .env file located one level above the current directory
source "$(dirname "$0")/../.env"

# Set initial volume to 0
amixer -q set "$VOLUME_CONTROL" 0%

# Duration to gradually increase volume (20 minutes)
DURATION=$((SUNRISE_DURATION * 60))  # Convert minutes to seconds

# Target volume (50%)
TARGET_VOLUME=50

# Initial volume (0%)
INITIAL_VOLUME=10

# Number of steps for gradual increase
STEPS=TARGET_VOLUME

# Calculate time interval for each step (in seconds)
STEP_INTERVAL=$((DURATION / STEPS))

# Gradually increase the volume from 0% to 50%
for ((i=0; i<=STEPS; i++)); do
    # Calculate the current volume step
    CURRENT_VOLUME=$((INITIAL_VOLUME + (TARGET_VOLUME * i / STEPS)))

    # Set the volume using amixer
    amixer set -q "$VOLUME_CONTROL" "${CURRENT_VOLUME}%"

    # Wait for the next step interval
    sleep $STEP_INTERVAL
done
