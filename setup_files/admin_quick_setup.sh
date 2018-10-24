#!/bin/bash

# script path, filename, directory
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"

echo ""
echo "Quick Setup will attempt to do the following:"
echo " - Add the resetGuest script to /usr/local/bin"
echo " - Add the Mac Lab default background to the Pictures Library"
echo "   (This picture can be changed by changing the file in the accompanying folder 'setup_files')"
echo ""
echo "Type y to continue with setup, type anything else to cancel:"
	
read INPUT
if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ]
then
	echo "Quick Setup Progress:"
	echo ""
	echo " > Copying Background.png to the Desktop Pictures library;"
	if [ -f "$PROG_DIR"/"Background.jpg" ]
	then
		sudo cp "$PROG_DIR"/Background.jpg /Library/"Desktop Pictures"
		echo " + Copied."
	else
		echo " ERROR: Background.png not found!"
	fi
	echo ""
	echo " > Copying the resetUser script to usr/local/bin;"
	if [ -f "$PROG_DIR"/"resetGuest.sh" ]
	then
		sudo cp "$PROG_DIR"/resetGuest.sh /usr/local/bin
		echo " + Copied."
	else
		echo " ERROR: resetGuest.sh not found!"
	fi
	echo ""
	echo " > Adjusting CHCLCGuest's Applications folder;"
	cd /Users/chclcguest/
	sudo rm -rf /Users/chclcguest/Applications/*
	sudo chmod 555 /Users/chclcguest/Applications
	sudo chflags schg /Users/chclcguest/Applications
	echo " + Configured."
	echo ""
	echo "Quick Setup administration complete."
	echo "Please rerun as the Guest account to complete full setup."
fi
exit