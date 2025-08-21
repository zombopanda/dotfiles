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
if [ "$(which brew)" != "/usr/local/bin/brew" ] && [ "$(which brew)" != "/opt/homebrew/bin/brew" ]; then
    echo -e "${green}Installing Brew...${no_color}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew analytics off

brew install git yadm rcmdnk/file/brew-file
yadm clone https://github.com/zombopanda/dotfiles.git

if command -v mas >/dev/null 2>&1; then
  mas account >/dev/null 2>&1 || echo "⚠️ Login to App Store before running brew-file MAS installs."
fi
brew file install

# load asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

SCRIPT_DIR=$(dirname "$0")

# Set macOS defaults
"${SCRIPT_DIR}/macos-defaults.sh"

# Set the order of apps in the Dock
"${SCRIPT_DIR}/dock.sh"

## Install asdf
asdf plugin add bun https://github.com/cometkim/asdf-bun.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf install

TMPDIR="$(mktemp -d)"; trap 'rm -rf "$TMPDIR"' EXIT

# Create a tmp directory
mkdir -p "$TMPDIR"
cd "$TMPDIR"

# Install setapp-cli
git clone https://github.com/leonsilicon/setapp-cli.git
cd setapp-cli

# Ensure bun exists
if ! command -v bun >/dev/null 2>&1; then
  asdf install bun latest && asdf global bun latest
fi
bun install

# Install setapp apps
while IFS= read -r app; do
  [[ -z "$app" ]] && continue
  bun run bin/setapp.ts install --name "$app"
done < "$HOME/.config/bootstrap/setapp.txt"

cd ~

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
