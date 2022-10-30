
.PHONY: keyboard
keyboard:
	defaults write Apple\ Global\ Domain KeyRepeat -int 2
	defaults write Apple\ Global\ Domain InitialKeyRepeat -int 15
	defaults write com.apple.HIToolbox AppleFnUsageType -int 2
	defaults write Apple\ Global\ Domain AppleKeyboardUIMode -int 0
	@# Keyboard Shortcuts
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 10 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 11 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 12 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 13 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 175 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 190 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 222 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 52 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 53 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 54 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 7 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 8 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 9 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 162 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 181 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 21 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 25 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 26 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 59 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 53 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 98 "<dict><key>enabled</key><false/></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
