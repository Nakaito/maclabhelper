#Sets the desktop background to a default picture. Tip: replace the file using the same filename at the specified location.
echo "Setting background"
#osascript -e 'tell application "System Events" to set picture of every desktop to ("/Library/Desktop Pictures/Background.jpg" as POSIX file as alias)'
if [ -f "/Library/Desktop Pictures/Background.jpg" ]
then
	#osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Background.jpg"' #better?
	osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Library/Desktop Pictures/Background.jpg"' #best
else
	osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Library/Desktop Pictures/Solid Colors/Solid Gray Pro Dark.png"'
fi

#Cleans out the various folders (excluding Documents and Public) of the User account, and Trash.
echo "Cleaning non-critical User folders"
rm -rf ~/Applications/*
rm -rf ~/"Creative Cloud Files"/*
rm -rf ~/Desktop/*
rm -rf ~/Documents/*
rm -rf ~/Downloads/*
rm -rf ~/Movies/*
rm -rf ~/Music/*
rm -rf ~/Pictures/*
rm -rf ~/Public/*
rm -rf ~/.Trash/*

#Cleans out the Documents folder, except the Adobe and Maya prefs folders. NOTE: Do we need to save these from le fire? If not, add an entry for the Documents folder above.
#echo "Cleaning User/Documents, except Adobe and Maya settings"
#cd /Users/chclcguest/Documents
#find . -maxdepth 1 | grep -v "Adobe" | grep -v "maya" | xargs rm -r

#Cleans out the Public folder, except the Drop Box folder. Oops. Don hangray
#echo "Cleaning ~/Public, except the Drop Box"
#cd /Users/chclcguest/Public
#find . -maxdepth 1 | grep -v "Drop Box" | xargs rm -r

#Cleans out the remainder of the User folder, exlcuding everything tidied previously. Figure out how to ignore all hidden.
#echo "Cleaning the remainder of the User base folder"
#cd /Users/chclcguest
#find . -maxdepth 1 -not -path '*/\.*' | grep -v "." | grep -v "Adlm" | grep -v "Adobe" | grep -v "Applications" | grep -v "Creative Cloud Files" | grep -v "Desktop" | grep -v "Documents" | grep -v "Downloads" | grep -v "Library" | grep -v "Movies" | grep -v "Music" | grep -v "Pictures" | grep -v "Public" | grep -v "pymel.log" | grep -v "xgen" | xargs rm -r

#Cleans out the scratch drive of all files older than 14 days, excluding some system folders.
#cd /Volumes/Scratch/
#find . -maxdepth 1 -mtime +14 | grep -v "DS_Store" | grep -v "DocumentRevisions-V100" | grep -v "fseventsd" | grep -v "Spotlight-V100" | grep -v "TemporaryItems" | grep -v "Trashes" | xargs rm -r

#osascript -e 'tell application (path to frontmost application as text) to display dialog "The User Account has been cleared."'

#Unhides the Dock, if hidden
osascript -e "tell application \"System Events\" to set the autohide of the dock preferences to false"