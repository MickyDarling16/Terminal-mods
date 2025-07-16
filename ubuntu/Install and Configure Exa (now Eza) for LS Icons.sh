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

    # Instructions for adding aliases to profile.sh:
    # Open your profile.sh file (e.g., using 'code ~/profile.sh' or 'nano ~/profile.sh')
    # Add the following lines to the end of the file:

    # # Alias ls to eza for enhanced output with icons and colors
    # if command -v eza &> /dev/null; then # Changed 'exa' to 'eza'
    #     alias ls='eza --icons --group-directories-first' # Changed 'exa' to 'eza'
    #     alias ll='eza -alF --icons --group-directories-first' # Changed 'exa' to 'eza'
    #     alias la='eza -a --icons --group-directories-first' # Changed 'exa' to 'eza'
    #     alias l='eza -F --icons --group-directories-first' # Changed 'exa' to 'eza'
    # fi

    # After adding these lines, save profile.sh and then run 'source ~/.bashrc'
    # or simply close and reopen your terminal.
    