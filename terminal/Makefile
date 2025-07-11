
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,bat)
	mkdir -p ~/.config/bat/themes/
	$(call assert_directory_exists,~/.config/bat/themes/)

.DEFAULT_GOAL := all
.PHONY: all
all: preq
	@# https://apple.stackexchange.com/q/344401/130792
	@plutil -replace "Window Settings.Tomorrow Night" -xml "$$(cat Tomorrow-Night.xml)" ~/Library/Preferences/com.apple.Terminal.plist && \
	defaults write com.apple.Terminal "Default Window Settings" -string "Tomorrow Night" && \
	defaults write com.apple.Terminal "Startup Window Settings" -string "Tomorrow Night"
	@# https://github.com/sharkdp/bat#adding-new-themes
	ln -s -f $(realpath .)/Tomorrow-Night.tmTheme ~/.config/bat/themes/Tomorrow-Night.tmTheme
	bat cache --build
