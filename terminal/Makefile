
include ../base.mk

THEME := $(shell sed -n '4,251p' "Tomorrow Night.terminal")

.PHONY: all
all:
	@# https://apple.stackexchange.com/q/344401/130792
	@echo plutil -replace Window\ Settings.Tomorrow\ Night -xml "\$$(THEME)" ~/Library/Preferences/com.apple.Terminal.plist
	@plutil -replace Window\ Settings.Tomorrow\ Night -xml "$(THEME)" ~/Library/Preferences/com.apple.Terminal.plist
	defaults write com.apple.Terminal "Default Window Settings" -string "Tomorrow Night"
	defaults write com.apple.Terminal "Startup Window Settings" -string "Tomorrow Night"
	@# https://apple.stackexchange.com/q/352354/130792
	osascript -e 'tell application "Terminal" to set font name of settings set "Tomorrow Night" to "Menlo"'
	osascript -e 'tell application "Terminal" to set font size of settings set "Tomorrow Night" to 18'
	osascript -e 'tell application "Terminal" to quit'
