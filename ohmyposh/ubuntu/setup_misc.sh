#!/bin/bash

# This script installs zoxide and defines helper functions for the terminal.

echo "Running miscellaneous modules and configurations script..."

# Check and install Zoxide using apt
echo "Checking for Zoxide..."
if ! command -v zoxide &> /dev/null; then
    echo "Zoxide not found. Attempting to install via apt..."
    # Update apt package list before installing
    sudo apt update
    sudo apt install -y zoxide
    if [ $? -eq 0 ]; then
        echo "Zoxide installed successfully via apt."
    else
        echo "Failed to install Zoxide via apt. Falling back to curl installation..."
        # Fallback to curl installation if apt fails (e.g., older Ubuntu version)
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        if [ $? -eq 0 ]; then
            echo "Zoxide installed successfully via curl."
        else
            echo "Failed to install Zoxide via curl as well. Please check your internet connection and permissions."
            exit 1
        fi
    fi
else
    echo "Zoxide is already installed."
fi

echo "Miscellaneous setup script completed."