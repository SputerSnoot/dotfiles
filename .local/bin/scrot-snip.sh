#!/bin/bash
# screenshot region, copy to clipboard, save to collection

temp_file=$(mktemp /tmp/screenshot_XXXXXX.png)

scrot --select --freeze --silent --overwrite --file "$temp_file"

if [ ! -s "$temp_file" ]; then
    rm "$temp_file"
    exit 1
fi

dimensions=$(identify -format '%wx%h' $temp_file)
datetime=$(date '+%Y-%m-%d_%H:%M:%S')
destination_dir=~/pictures/screenshots/
filename="${datetime}_${dimensions}_scrot.png"

mkdir -p "$destination_dir"

xclip -selection clipboard -t image/png -i "$temp_file"

mv "$temp_file" "$destination_dir$filename"
