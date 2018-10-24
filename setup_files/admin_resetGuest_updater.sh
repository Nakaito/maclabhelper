#!/bin/bash

# script path, filename, directory
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
ERRORS=0

echo ""

echo "Update Progress:"
echo ""
echo ""
echo " > Copying the resetUser script to usr/local/bin;"
if [ -f "$PROG_DIR"/"resetGuest.sh" ]
then
	sudo cp "$PROG_DIR"/resetGuest.sh /usr/local/bin
	echo " + Copied."
else
	echo " ERROR: $PROG_DIR/resetGuest.sh not found!"
	let ERRORS++
fi
echo ""
if [ "$ERRORS" -eq "0" ]
then
	echo "Update complete."
else
	echo "$ERRORS error(s) found. Please fix and rerun."
fi
exit