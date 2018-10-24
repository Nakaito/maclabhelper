#!/bin/bash

# script path, filename, directory
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"

# commands were taken from https://discussions.apple.com/thread/7021271

echo " > Copying Background.png to the Desktop Pictures library;"
if [ -f "$PROG_DIR"/"Background.jpg" ]
then
    sudo cp "$PROG_DIR"/Background.jpg /Library/"Desktop Pictures"
    echo " + Copied."
else
    echo " ERROR: Background.png not found!"
fi
exit