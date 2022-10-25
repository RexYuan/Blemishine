
include ../base.mk

.PHONY: all
all:
	@# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
	@# auto expand save and print panels
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
	@# disable auto formatting
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
