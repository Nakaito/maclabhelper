osascript -e 'tell application "System Preferences" to reveal anchor "displaysDisplayTab" of pane "com.apple.preference.displays"'
osascript -e 'tell application "System Events" to set visible of process "System Preferences" to false'
osascript -e 'tell application "System Events" to tell process "System Preferences" to tell window "iMac" to click radio button "Default for display" of radio group 1 of tab group 1'
osascript -e 'quit application "System Preferences"'