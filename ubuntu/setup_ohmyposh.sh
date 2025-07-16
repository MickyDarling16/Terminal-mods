#!/bin/bash

# This script installs Oh My Posh and provides instructions for Nerd Font installation.

echo "Running Oh My Posh and Nerd Font installation script..."

# Check if Oh My Posh is installed
echo "Checking for Oh My Posh..."
if ! command -v oh-my-posh &> /dev/null; then
    echo "Oh My Posh is not installed. Installing now..."
    # Install Oh My Posh for Linux (amd64 architecture)
    # Refer to https://ohmyposh.dev/docs/installation/linux
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
    if [ $? -eq 0 ]; then
        echo "Oh My Posh installed successfully!"
    else
        echo "Failed to install Oh My Posh."
        exit 1
    fi
else
    echo "Oh My Posh is already installed."
fi

# Nerd Font Installation Instructions
echo ""
echo "================================================================================="
echo "IMPORTANT: Nerd Font Installation"
echo "Oh My Posh themes require a Nerd Font to display correctly."
echo "You need to install a Nerd Font (e.g., CaskaydiaCove Nerd Font) on your WINDOWS system."
echo "Then, configure your Windows Terminal profile for Ubuntu to use this font."
echo ""
echo "Recommended steps:"
echo "1. Go to https://www.nerdfonts.com/font-downloads"
echo "2. Download 'CaskaydiaCove Nerd Font' (or your preferred Nerd Font)."
echo "3. Unzip the downloaded file."
echo "4. Right-click on the .ttf (TrueType Font) files and select 'Install' or 'Install for all users'."
echo "5. Open Windows Terminal Settings (Ctrl+,)."
echo "6. Go to 'Profiles' > 'Ubuntu' (or your WSL distribution name)."
echo "7. Under 'Appearance', set 'Font face' to 'CaskaydiaCove Nerd Font Mono' (or the Nerd Font you installed)."
echo "8. Save your settings."
echo "================================================================================="
echo ""

echo "Oh My Posh installation script completed."
