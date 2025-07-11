#!/bin/bash

APP_CMD="/opt/AmneziaVPN/client/bin/AmneziaVPN"
DESKTOP_FILE="/usr/share/applications/AmneziaVPN.desktop"

# Check if the process is running by command line match
PID=$(pgrep -f "$APP_CMD")

if [ -n "$PID" ]; then
    echo "AmneziaVPN is running (PID: $PID). Killing..."
    kill "$PID"
    if [ $? -eq 0 ]; then
        echo "AmneziaVPN stopped."
    else
        echo "Failed to stop AmneziaVPN."
    fi
else
    echo "AmneziaVPN is not running. Starting with dex..."
    dex "$DESKTOP_FILE"
    if [ $? -eq 0 ]; then
        echo "AmneziaVPN started successfully."
    else
        echo "Failed to start AmneziaVPN using dex."
    fi
fi
