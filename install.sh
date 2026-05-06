#!/bin/bash

# fastmac | Lloyd D. Jones | 2026

echo "Starting fastmac install..."
echo "Installing fastmac version 1.0"

# --- Homebrew ---
# Homebrew must be installed prior to installing other packages as these
# packages depend on Homebrew to install.
echo "Checking if Homebrew is installed..."
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is installed"
  brew --version
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Load brew into the current shell to run installers
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null ||
    eval "$(/usr/local/bin/brew shellenv)"
fi

# --- Install function declaration ---
# Once Homebrew is instsalled, this function can be used to check and
# install packages directly from Homebrew to the machine.
install_if_missing() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Installing $1"
    brew install "$1"
  else
    echo "$1 is already installed"
  fi
}

# Install fastmac packages and applications
echo "Installing packages and applications..."
install_if_missing node
install_if_missing python
install_if_missing git
install_if_missing github-cli
install_if_missing fastfetch
install_if_missing nvim
install_if_missing ghostty
install_if_missing spotify
install_if_missing cursor
install_if_missing postman
install_if_missing chromium
install_if_missing aerospace

# Install configuration packages
echo "Installing configuration packages..."
# NerdFont for CLI applications
echo "Installing NerdFont mono for CLI applications..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# JankyBorders for Aerospace window management
echo "Installing JankyBorders for Aerospace window management..."
brew tap FelixKratz/formulae
brew install borders

# LazyVim configuration install
echo "Installing and initializing LazyVim configuration to Nvim..."
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Handle dotfile replacement
cp dotfiles/.aerospace.toml ~/.aerospace.toml

echo "fastmac install completed"
