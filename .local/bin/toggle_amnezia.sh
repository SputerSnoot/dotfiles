#!/usr/bin/env bash


STATE_FILE="$HOME/.current-amnezia-state"

# If file doesn't exist, initialize to 0 (disabled)
if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

APP_CMD="/opt/AmneziaVPN/client/bin/AmneziaVPN"
DESKTOP_FILE="/usr/share/applications/AmneziaVPN.desktop"

# Check if the process is running by command line match
PID=$(pgrep -f "$APP_CMD")

CURRENT_STATE=$(cat "$STATE_FILE")

if [[ "$CURRENT_STATE" == "0" ]]; then
    echo 1 > "$STATE_FILE"
    dex "$DESKTOP_FILE"
    if [ $? -eq 0 ]; then
        echo "AmneziaVPN started successfully."
    else
        echo "Failed to start AmneziaVPN"
    fi
elif [[ "$CURRENT_STATE" == "1" ]]; then
    echo 0 > "$STATE_FILE"
    kill "$PID"
    if [ $? -eq 0 ]; then
        echo "AmneziaVPN stopped."
    else
        echo "Failed to stop AmneziaVPN."
    fi
else
    echo "Invalid state detected: '$CURRENT_STATE'. Resetting to 0"
    echo 0 > "$STATE_FILE"
fi
