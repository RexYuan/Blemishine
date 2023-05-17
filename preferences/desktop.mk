
.PHONY: desktop
desktop:
	@# General
	defaults write Apple\ Global\ Domain AppleInterfaceStyle -string "Dark"
	@# Dock
	defaults write com.apple.dock tilesize -int 64
	defaults write com.apple.dock magnification -bool false
	defaults write com.apple.dock orientation -string "bottom"
	defaults write com.apple.dock mineffect -string "genie"
	defaults write Apple\ Global\ Domain AppleActionOnDoubleClick -string "Maximize"
	defaults write com.apple.dock minimize-to-application -bool false
	defaults write com.apple.dock autohide -bool false
	defaults write com.apple.dock launchanim -bool true
	defaults write com.apple.dock show-process-indicators -bool true
	defaults write com.apple.dock show-recents -bool false
	@# Menu Bar
	defaults write Apple\ Global\ Domain AppleMenuBarVisibleInFullscreen -bool false
	defaults write Apple\ Global\ Domain _HIHideMenuBar -bool false
	@# Windows & Apps
	defaults write Apple\ Global\ Domain AppleWindowTabbingMode -string "always"
	defaults write Apple\ Global\ Domain NSCloseAlwaysConfirmsChanges -bool true
	defaults write Apple\ Global\ Domain NSQuitAlwaysKeepsWindows -bool false
	defaults write com.apple.WindowManager GloballyEnabled -bool false
	@# https://stackoverflow.com/q/17528688/2448540
	open -a "Google Chrome" --args --make-default-browser
	@# Mission Control
	defaults write com.apple.dock mru-spaces -bool true
	defaults write Apple\ Global\ Domain AppleSpacesSwitchOnActivate -bool false
	defaults write com.apple.dock expose-group-apps -bool true
	defaults write com.apple.spaces spans-displays -bool false
	@# Shortcuts
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 32 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 33 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 34 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 36 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 37 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 45 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 46 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 48 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 49 "<dict><key>enabled</key><false/></dict>"
	@# Hot Corners
	defaults write com.apple.dock wvous-bl-corner -int 0
	defaults write com.apple.dock wvous-br-corner -int 0
	defaults write com.apple.dock wvous-tl-corner -int 0
	defaults write com.apple.dock wvous-tr-corner -int 0
