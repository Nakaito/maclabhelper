#!/bin/bash

# script path, filename, directory
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"

echo ""
echo "NOTE: Make sure you have already run this helper as an Admin!"
sleep 1s
echo ""
echo "Quick Setup will attempt to do the following:"
echo " - Disable the Time Machine prompt for external media"
echo " - Disable Apple Photos as the default program for SD cards"
echo " - Set up the resetGuest script for clearing the guest account at login"
echo " - Stop Safari from opening 'safe' files automagically"
echo " - Enable expanded Save and Print dialogs by default"
echo ""
echo "Type y to continue with setup, type anything else to cancel:"

read INPUT
if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ]
then
	echo ""
	echo "Quick Setup Progress:"
	echo ""
	defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool TRUE
	echo " + Time Machine prompt disabled."
	echo ""
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
	echo " + Apple Photos auto-launch disabled."
	echo ""
	defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
	echo " + Stopped Safari from opening 'safe' files automagically."
	echo ""
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    echo " + Enabled expanded Save and Print dialogs by default."
	echo ""
	echo " > Configuring the resetUser script;"
	cp "$PROG_DIR"/com.user.loginscript.plist ~/Library/LaunchAgents
	launchctl load ~/Library/LaunchAgents/com.user.loginscript.plist
	echo " + Configured."
	echo ""
	echo "Quick Setup complete!"
fi
exit