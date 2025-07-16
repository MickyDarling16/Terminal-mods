# This file contains configurations to be added to your ~/.bashrc file.

# Explicitly set TERM for better color support in some environments
export TERM="xterm-256color"

# Oh My Posh initialization
# Ensure thm1.omp.json is copied to ~/.poshthemes/
if command -v oh-my-posh >/dev/null 2>&1 && [ -f "/mnt/c/Users/micha/Desktop/Terminal-mods/Powershell/ohMyPosh/Poshthemes/thm1.omp.json" ]; then
    eval "$(oh-my-posh init bash --config /mnt/c/Users/micha/Desktop/Terminal-mods/Powershell/ohMyPosh/Poshthemes/thm1.omp.json)"
else
    echo "Warning: oh-my-posh or the theme config file is missing."
fi

# Zoxide initialization
# Ensure zoxide is installed via setup_misc.sh
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
else
    echo "Warning: zoxide is not installed."
fi

# History deduplication and settings
# This helps keep your command history clean
export HISTCONTROL=ignoredups:erasedups # Ignore duplicates and erase previous duplicates
export HISTSIZE=10000                   # Number of lines or commands in the history file
export HISTFILESIZE=10000               # Maximum number of lines contained in the history file
shopt -s histappend                     # Append to the history file, don't overwrite it

# Function to start Python virtual environments
# Assumes virtual environments are located in /mnt/c/Users/micha/Desktop/projects/
# and are named 'dtscience' (for py13) and 'dtsciencep12' (for py12).
function start-environment {
    local current_location=$(pwd) # Save current location

    # Navigate to the projects directory first, if it exists
    if [ -d "/mnt/c/Users/micha/Desktop/projects" ]; then
        cd "/mnt/c/Users/micha/Desktop/projects" || { echo "Could not navigate to projects directory."; return 1; }
    else
        echo "Projects directory /mnt/c/Users/micha/Desktop/projects does not exist."
        return 1
    fi

    # Activate the virtual environment based on the argument
    if [[ "$1" == "--py13" ]]; then
        if [ -f "dtscience/bin/activate" ]; then
            source dtscience/bin/activate
            echo "Python 3.13 virtual environment activated."
        else
            echo "Error: dtscience/bin/activate not found."
        fi
    elif [[ "$1" == "--py12" ]]; then
        if [ -f "dtsciencep12/bin/activate" ]; then
            source dtsciencep12/bin/activate
            echo "Python 3.12 virtual environment activated."
        else
            echo "Error: dtsciencep12/bin/activate not found."
        fi
    else
        echo "No virtual environment specified. Use --py13 or --py12."
    fi

    # Navigate back to the original location
    cd "$current_location" || { echo "Could not navigate back to original directory."; return 1; }
}

# Aliases
alias startVM="start-environment" # Alias for starting virtual environments
# Note: The 'Remove-HistoryDuplicates' function from PowerShell doesn't have a direct
# simple Bash equivalent that's commonly aliased. The HISTCONTROL settings above
# handle basic deduplication. If more advanced history management is needed,
# a custom Bash function would be required. For now, we'll rely on HISTCONTROL.
# For a 'dup' alias, you could use:
# alias dup='history -d $(history | cut -c 8- | sort -u | uniq -d | awk "{print \$1}")'
# However, this is more complex and might not be what the user expects.
# Sticking to the HISTCONTROL for simplicity.

# LS_COLORS setup for traditional 'ls' with rich colors
# This will generate a default .dircolors file if one doesn't exist,
# and then source it to apply LS_COLORS.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -alF' # Standard 'll' alias
    alias la='ls -A'
    alias l='ls -CF'
fi
