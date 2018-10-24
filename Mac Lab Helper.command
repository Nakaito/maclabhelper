#!/bin/bash

# script path, filename, directory
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
ERRORS=0
NAME_ADMIN="chcadmin"
NAME_GUEST="chclcguest"
echo ""
echo "Welcome to the Mac Lab Setup Helper!"
echo ""
echo "Choose an option:"
echo "  1) Run Quick Setup"
echo "  2) Edit Time Machine Prompt"
echo "  3) Edit Apple Photos as the default for SD cards"
echo "  4) Show or hide hidden files in Finder"
echo "  5) Update the resetUser script on this system"
echo "  6) Update the default background from setup_files"
echo "  Enter anything else to quit"
read INPUT

if [ "$INPUT" = "1" ]
then
	echo ""
	echo "Run Quick Setup for:"
	echo " 1) Admin"
	echo " 2) Guest"
	echo " 3) Both"
	echo " Or type anything else to quit"
	
	read INPUT
	if [ "$INPUT" = "1" ]
	then
		while [ ! -e /Users/$NAME_ADMIN ]
		do
			echo ""
			echo "Error: the $NAME_ADMIN account doesn't exist on this system."
			echo "Please enter the folder name (not the username) of the user you want run as administrator:"
			read NAME_ADMIN
		done
		echo ""
		echo "Switching to a secure environment."
		echo "Please enter the Admin password twice:"
		#sudo sh "$PROG_DIR"/setup_files/admin_quick_setup.sh
		su $NAME_ADMIN -c "sudo sh '$PROG_DIR'/setup_files/admin_quick_setup.sh"
	elif [ "$INPUT" = "2" ]
	then
		sh "$PROG_DIR"/setup_files/guest_quick_setup.sh
	elif [ "$INPUT" = "3" ]
	then
		echo ""
		echo ""
		echo "Running the Admin Quick Setup..."
		echo ""
		echo "Switching to a secure environment."
		echo "Please enter the Admin password twice:"
		su $NAME_ADMIN -c "sudo sh '$PROG_DIR'/setup_files/admin_quick_setup.sh"
		echo ""
		echo ""
		echo "Running the Guest Quick Setup..."
		sh "$PROG_DIR"/setup_files/guest_quick_setup.sh
	fi
	
elif [ "$INPUT" = "2" ]
then
	echo ""
	echo "Turn off Time Machine prompt for external media? "
	read INPUT
	if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ] || [ "$INPUT" = "1" ]
	then
		defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool TRUE
		echo "Time Machine prompt disabled."
	else
		defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool FALSE
		echo "Time Machine prompt enabled."
	fi
	
elif [ "$INPUT" = "3" ]
then
	echo ""
	echo "Turn off Apple Photos as default application for SD cards? "
	read INPUT
	if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ] || [ "$INPUT" = "1" ]
	then
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
		echo "Apple Photos auto-launch disabled."
	else
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool NO
		echo "Apple Photos auto-launch enabled."
	fi
	
elif [ "$INPUT" = "4" ]
then
	echo ""
	echo "Show hidden files and folders in Finder (will restart Finder either way)? "
	read INPUT
	if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ] || [ "$INPUT" = "1" ]
	then
		defaults write com.apple.finder AppleShowAllFiles -bool TRUE
		killall Finder
		echo "Showing hidden files. Re-run and say no to hide them."
	else
		defaults write com.apple.finder AppleShowAllFiles -bool FALSE
		killall Finder
		echo "Leaving hidden files and folders hidden."
	fi
	
elif [ "$INPUT" = "5" ]
then
	echo "This Utility updates the resetUser script on the system to the current one in this program's setup files."
	echo ""
	echo "Type y to continue, type anything else to quit:"
	read INPUT
	if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ] || [ "$INPUT" = "1" ]
	then
		echo ""
		echo ""
		echo "Running the Updater, requires administrative access..."
		echo ""
		echo "Switching to a secure environment."
		echo "Please enter the Admin password twice:"
		echo "  (once to switch to the Admin account, again to authorize sudo)"
		su $NAME_ADMIN -c "sudo sh '$PROG_DIR'/setup_files/admin_resetGuest_updater.sh"
	fi

elif [ "$INPUT" = "6" ]
then
    echo "Update the default background from setup_files/Background.jpg?"
    echo ""
	echo "Type y to continue, type anything else to quit:"
	read INPUT
	if [ "$INPUT" = "y" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "yes" ] || [ "$INPUT" = "YES" ] || [ "$INPUT" = "Yes" ] || [ "$INPUT" = "1" ]
	then
        echo ""
		echo ""
		echo "Running the Updater, requires administrative access..."
		echo ""
		echo "Switching to a secure environment."
		echo "Please enter the Admin password twice:"
		echo "  (once to switch to the Admin account, again to authorize sudo)"
        su $NAME_ADMIN -c "sudo sh '$PROG_DIR'/setup_files/setBackground_admin.sh"
    fi
	
#elif [ "$INPUT" = "0" ] #uninstall
#then
#	launchctl unload ~/Library/LaunchAgents/com.user.loginscript.plist

else
	echo "No option chosen."
	
fi
echo ""
echo "Program complete, exiting!"
sleep 2s
echo ""
echo ""
exit