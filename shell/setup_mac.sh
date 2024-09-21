#!/bin/bash

# ---------------------------------------------------------
# macOS Setup Script - One-Time Setup for macOS Environment
# ---------------------------------------------------------

# 1. macOS System Preferences

# Set fast keyboard repeat rate
echo "Setting keyboard repeat rate..."
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Automatically hide the Dock and set icon size
echo "Configuring Dock settings..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
killall Dock  # Restart Dock once to apply all changes at once

# Show hidden files and all file extensions in Finder
echo "Configuring Finder settings..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable auto-capitalization, period substitution, smart quotes, and smart dashes
echo "Disabling smart typing features (capitalization, quotes, dashes)..."
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Set screenshots to save to ~/Screenshots
echo "Setting screenshot save location..."
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Prevent sleep when the lid is closed
echo "Disabling sleep on lid close..."
sudo pmset -a disablesleep 1

# Enable tap to click for the trackpad
echo "Enabling tap-to-click on trackpad..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Restart Dock and Finder to apply changes
echo "Restarting Dock and Finder..."
killall Dock
killall Finder

# 2. Install Developer Tools with Homebrew

# Ensure Homebrew is installed and updated
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew non-interactively..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null || { echo "Homebrew installation failed!"; exit 1; }

    # Add Homebrew to PATH for this session
    echo "Adding Homebrew to PATH..."
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Updating Homebrew..."
    eval "$(/opt/homebrew/bin/brew shellenv)"  # Ensure Homebrew is in the PATH
    brew update && brew upgrade || { echo "Homebrew update/upgrade failed!"; exit 1; }
fi

# Install essential developer tools
echo "Installing developer tools via Homebrew..."
brew install git tmux neovim node yarn jq || { echo "Failed to install developer tools!"; exit 1; }

# Clean up outdated versions from the Homebrew cellar
brew cleanup

# 3. Set Up Development Environment

# Set up NVM (Node Version Manager) for managing Node.js versions
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM..."
    brew install nvm
    mkdir -p ~/.nvm
fi
source $(brew --prefix nvm)/nvm.sh || { echo "Failed to source NVM!"; exit 1; }

# Install the latest version of Node.js
echo "Installing and using the latest Node.js version..."
nvm install node
nvm use node

# pnpm setup (JavaScript/TypeScript package manager)
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    curl -fsSL https://get.pnpm.io/install.sh | sh - || { echo "Failed to install pnpm!"; exit 1; }
fi

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# bun setup (fast JavaScript runtime and bundler)
if [ ! -d "$HOME/.bun" ]; then
    echo "Installing bun..."
    curl https://bun.sh/install | bash || { echo "Failed to install bun!"; exit 1; }
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Set up global Git configuration
echo "Configuring Git..."
git config --global user.name "Dean Attias"
git config --global user.email "dean.attias@gmail.com"
git config --global init.defaultBranch main

# 4. Custom Utilities and Functions

# Create a utility function for updating everything
update_all() {
    echo "Updating Homebrew packages..."
    brew update && brew upgrade && brew cleanup
    echo "Updating Node.js packages with pnpm..."
    pnpm update --global
}

# Disable smart typing features
disable_smart_typing() {
    echo "Disabling smart typing features..."
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    echo "Smart typing features disabled."
}

# Restart Dock and Finder for immediate changes
restart_system_ui() {
    echo "Restarting Dock and Finder..."
    killall Dock
    killall Finder
    echo "Dock and Finder restarted."
}

# 5. Final Output
echo "Dean's macOS system setup complete! Please restart your terminal for changes to take effect."