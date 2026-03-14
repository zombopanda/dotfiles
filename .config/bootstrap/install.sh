#!/bin/bash
set -euo pipefail

# Colors!
green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"
purple="\033[1;35m"
blue="\033[1;34m"
no_color="\033[0m"

# Homebrew
## Install
if ! command -v brew >/dev/null 2>&1; then
    echo -e "${green}Installing Brew...${no_color}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off

brew install git yadm rcmdnk/file/brew-file
brew install --cask cursor
yadm clone https://github.com/zombopanda/dotfiles.git
export HOMEBREW_BREWFILE_CURSOR=1
brew file install

# Activate mise and install tool versions from .tool-versions
eval "$(mise activate bash)"
mise install

SCRIPT_DIR=$(dirname "$0")

# Set macOS defaults
. "${SCRIPT_DIR}/macos-defaults.sh"

# Set the order of apps in the Dock
. "${SCRIPT_DIR}/dock.sh"

echo "Please open SetApp and log in..."
read -n 1 -s
echo "Thanks, moving on."

# Create a tmp directory
_tmpdir="$(mktemp -d)"; trap 'rm -rf "$_tmpdir"' EXIT
cd "$_tmpdir"

# Install setapp-cli
git clone https://github.com/leonsilicon/setapp-cli.git
cd setapp-cli

# Ensure bun exists
if ! command -v bun >/dev/null 2>&1; then
  mise use --global bun@latest
fi
bun install

# Install setapp apps
while IFS= read -r app; do
  [[ -z "$app" ]] && continue
  bun run bin/setapp.ts install --name "$app"
done < "$HOME/.config/bootstrap/setapp.txt"

cd ~

# Install Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Restore mackup
mackup restore || true

# Set default shell to fish
FISH="$(command -v fish)"
if ! grep -qx "$FISH" /etc/shells; then
  echo "$FISH" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$FISH"

echo -e "${green}Setup complete!${no_color}"

echo -e "${purple}Reboot for some settings to take effect? (Y/n) ${no_color}"
read -p "" reboot
if [ "$reboot" != "N" ] && [ "$reboot" != "n" ]; then
    echo -e "${red}Rebooting...${no_color}"
    sudo reboot
fi
