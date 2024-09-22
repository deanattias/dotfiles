#!/bin/bash

# ---------------------------------------------------------
# macOS Setup Script - One-Time Setup for macOS Environment
# ---------------------------------------------------------

# Function to check the success of commands
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed!"
        exit 1
    fi
}

# Function to restart Dock and Finder
restart_system_ui() {
    echo "Restarting Dock and Finder..."
    killall Dock
    killall Finder
}

# Function to add Homebrew to PATH if not already added
add_homebrew_to_path() {
    if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zshrc; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        echo "Added Homebrew to PATH in .zshrc."
    else
        echo "Homebrew is already in PATH."
    fi
}

# 1. macOS System Preferences
echo "Configuring macOS system preferences..."

# Set fast keyboard repeat rate
echo "Setting keyboard repeat rate..."
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Automatically hide the Dock and set icon size
echo "Configuring Dock settings..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
restart_system_ui

# Show hidden files and all file extensions in Finder
echo "Configuring Finder settings..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable auto-capitalization, period substitution, smart quotes, and smart dashes
echo "Disabling smart typing features..."
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Set screenshots to save to ~/Screenshots
echo "Setting screenshot save location..."
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
check_success "Setting screenshot location"

# Prevent sleep when the lid is closed (only on AC)
echo "Disabling sleep on lid close..."
sudo pmset -c disablesleep 1
check_success "Disabling sleep on lid close"

# Enable tap to click for the trackpad
echo "Enabling tap-to-click on trackpad..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Restart Dock and Finder to apply changes
restart_system_ui

# 2. Install Developer Tools with Homebrew
echo "Installing developer tools with Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew non-interactively..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
    check_success "Homebrew installation"
fi

# Add Homebrew to PATH
add_homebrew_to_path

# Ensure Homebrew is up-to-date
echo "Updating Homebrew..."
eval "$(/opt/homebrew/bin/brew shellenv)"  # Add this line to ensure PATH is set
brew update && brew upgrade
check_success "Homebrew update/upgrade"

# Install essential developer tools
echo "Installing essential developer tools..."
brew install git tmux neovim node
check_success "Installing developer tools"

# Clean up outdated versions from the Homebrew cellar
brew cleanup

# 3. Set Up Development Environment
echo "Setting up development environment..."

# Set up NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM..."
    brew install nvm
    mkdir -p ~/.nvm
fi
source $(brew --prefix nvm)/nvm.sh
check_success "Sourcing NVM"

# Install the latest version of Node.js
echo "Installing the latest Node.js version..."
nvm install node
nvm use node
check_success "Node.js installation"

# pnpm setup (JavaScript/TypeScript package manager)
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    curl -fsSL https://get.pnpm.io/install.sh | sh
    check_success "pnpm installation"
fi

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# bun setup (fast JavaScript runtime and bundler)
if [ ! -d "$HOME/.bun" ]; then
    echo "Installing bun..."
    curl https://bun.sh/install | bash
    check_success "bun installation"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Set up global Git configuration
echo "Configuring Git..."
git config --global user.name "Dean Attias"
git config --global user.email "dean.attias@gmail.com"
git config --global init.defaultBranch main

# 4. Custom Utilities and Functions
# Create utility function for updating everything
update_all() {
    echo "Updating Homebrew packages..."
    brew update && brew upgrade && brew cleanup
    echo "Updating Node.js packages with pnpm..."
    pnpm update --global
}

# 5. Final Output
echo "Dean's macOS system setup complete! Please restart your terminal for changes to take effect."