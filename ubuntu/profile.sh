# This file contains configurations to be added to your ~/.bashrc file.

# Explicitly set TERM for better color support in some environments
export TERM="xterm-256color"

# Clear existing LS_COLORS to avoid conflicts with exa_COLORS
unset LS_COLORS

# Custom EXA_COLORS for more appealing output (similar to PowerShell)
# Refer to 'man exa' for full list of options and color codes.
# Format: <key>=<color_code>;<attribute_code>:<key>=...
# Color Codes: 30-37 (foreground), 40-47 (background), 90-97 (bright foreground), 100-107 (bright background)
# Attribute Codes: 01 (bold), 04 (underline), 05 (blink), 07 (reverse), 08 (concealed)
export EXA_COLORS="di=94:fi=97:ex=92:lc=96:or=91:mi=91:pi=93:so=95:bd=93;01:cd=93;01:su=30;41:sg=30;46:st=30;44:ow=30;43:tw=30;42:da=90:in=90:fo=97:lp=90:uu=94:gn=94:gu=92:gd=31:gt=93:gs=96:gc=90:"

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
export HISTSIZE=10000                   # Number of lines or commands in the history list
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

# Diagnostic: Check exa's color support just before defining aliases
if command -v exa &> /dev/null; then
    echo "--- exa color support check ---"
    # This command should output a colored line if exa is capable of colors
    exa --color=always --no-icons --no-filesize --no-time --no-perms --no-user --no-group --no-links --no-git --no-header -l /dev/null 2>/dev/null || true
    echo "--- end exa color support check ---"
fi

# Alias ls to exa for enhanced output with icons and colors
if command -v exa &> /dev/null; then
    alias ls='exa -l --icons --group-directories-first --color=always' # Added --color=always
    alias ll='exa -alF --icons --git --header --group-directories-first'
    alias la='exa -a --icons --group-directories-first'
    alias l='exa -F --icons --group-directories-first'
fi
