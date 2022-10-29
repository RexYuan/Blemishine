
# https://superuser.com/q/455755/372113
# only settings for internal trackpad for now
.PHONY: trackpad
trackpad:
	@# Point & Click
	defaults write Apple\ Global\ Domain com.apple.trackpad.forceClick -bool false
	defaults write Apple\ Global\ Domain ContextMenuGesture -int 1
	defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
	defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
	defaults write Apple\ Global\ Domain com.apple.trackpad.scaling -float 0.6875
	defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 1
	defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -int 0
	@# Scroll & Zoom
	defaults write Apple\ Global\ Domain com.apple.swipescrolldirection -int 1
	defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
	defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 0
	defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
	@# More Gestures
	defaults write Apple\ Global\ Domain AppleEnableSwipeNavigateWithScrolls -int 0
	defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
	defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
	defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
	defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
	defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
	defaults write com.apple.dock showAppExposeGestureEnabled -int 1
	defaults write com.apple.dock showMissionControlGestureEnabled -int 1
	defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 0
	defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 0
	defaults write com.apple.dock showDesktopGestureEnabled -int 0
	defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
