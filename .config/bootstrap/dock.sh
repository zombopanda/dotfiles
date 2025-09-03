#!/usr/bin/env bash
set -euo pipefail
# ------------------------------------------
# Set exact Dock apps in specified order
# ------------------------------------------

# Clear the Dock of all apps
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# Add desired apps in the specified order
add_app_to_dock() {
  defaults write com.apple.dock persistent-apps -array-add "<dict>
    <key>tile-data</key>
    <dict>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>$1</string>
        <key>_CFURLStringType</key>
        <integer>0</integer>
      </dict>
    </dict>
  </dict>"
}

defaults write com.apple.dock persistent-apps -array

# Now add apps in the specified order
# DO NOT add Finder here - macOS will add it automatically
# add_app_to_dock "/System/Library/CoreServices/Finder.app"  # Remove this line
# TODO: For some reason Safari shows up as some weird symlink in the Dock - adding manually for now
# add_app_to_dock "/Applications/Safari.app"
add_app_to_dock "/System/Applications/Launchpad.app"
add_app_to_dock "/Applications/Cursor.app"
add_app_to_dock "/Applications/Telegram.app"
add_app_to_dock "/Applications/Ghostty.app"
add_app_to_dock "/Applications/Spotify.app"
add_app_to_dock "/Applications/Rocket.Chat.app"
add_app_to_dock "/Applications/Craft.app"
add_app_to_dock "/Applications/Google Chrome.app"
add_app_to_dock "/Applications/ChatGPT.app"
add_app_to_dock "/Applications/TickTick.app"
add_app_to_dock "/System/Applications/Mail.app"
add_app_to_dock "/Applications/Figma.app"


# Force Dock to restart to apply changes
killall Dock
