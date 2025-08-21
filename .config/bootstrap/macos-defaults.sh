#!/usr/bin/env bash

## MacOS system settings
echo -e "${yellow}Writing MacOS system settings...${no_color}"

# Set dock size
defaults write com.apple.dock "tilesize" -int "32"

# Don't show recents
defaults write com.apple.dock "show-recents" -bool "false"

# Set dock orientation to left
defaults write com.apple.dock "orientation" -string "left"

# Set magnification to 0
defaults write com.apple.dock "magnification" -bool "false"

# Show the `Quit` menu item in Finder
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# Show all file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# Firm click weight
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "2"

# Use fn key to switch keyboard input methods
defaults write com.apple.HIToolbox AppleFnUsageType -int "1"

# Enable keyboard navigation
defaults write NSGlobalDomain AppleKeyboardUIMode -int "2"

# Disable confirmation when closing unsaved windows (will autosave)
defaults write NSGlobalDomain "NSCloseAlwaysConfirmsChanges" -bool "true"

# Set the accent color to purple (options: Blue, Purple, Pink, Red, Orange, Yellow, Green, Graphite)
defaults write NSGlobalDomain AppleAccentColor -int "5"

# Set highlight color to accent color
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"

# Use the Caps Lock key to switch to and from U.S.
defaults write NSGlobalDomain TISRomanSwitchState -int "1"

# Hide Spotlight menu item
defaults write com.apple.Spotlight MenuItemHidden -bool true

# Show clock in menu bar
defaults write com.apple.menuextra.clock "IsAnalog" -bool "true"

# Show 24 hour format
defaults write com.apple.menuextra.clock "Show24Hour" -bool "true"

# Show date in menu bar
defaults write com.apple.menuextra.clock "ShowDate" -int "2"

# Restart Dock
killall Dock

# Restart Finder
killall Finder

killall cfprefsd 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS defaults applied successfully!"
