    #!/bin/bash

    echo "Setting up exa/eza for enhanced 'ls' output with icons..."

    # Update apt package list
    sudo apt update

    # Install eza (which replaces exa in some distributions)
    echo "Checking for eza and installing if not found..."
    if ! command -v eza &> /dev/null; then # Changed 'exa' to 'eza'
        sudo apt install -y eza # Changed 'exa' to 'eza'
        if [ $? -eq 0 ]; then
            echo "Eza installed successfully."
        else
            echo "Failed to install eza via apt. Please check your internet connection and permissions."
            exit 1
        fi
    else
        echo "Eza is already installed."
    fi

    echo "Eza setup script completed. Now, you need to add aliases to your profile.sh."
    