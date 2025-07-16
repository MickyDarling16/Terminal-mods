# This file contains configurations to be added to your ~/.bashrc file.

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

# Alias ls to eza for enhanced output with icons and colors
if command -v eza &> /dev/null; then # Changed 'exa' to 'eza'
    alias ls='eza --icons --group-directories-first' # Changed 'exa' to 'eza'
    alias ll='eza -alF --icons --group-directories-first' # Changed 'exa' to 'eza'
    alias la='eza -a --icons --group-directories-first' # Changed 'exa' to 'eza'
    alias l='eza -F --icons --group-directories-first' # Changed 'exa' to 'eza'
fi

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


# Custom EXA_COLORS for more appealing output (similar to PowerShell)
# Refer to 'man eza' for full list of options and color codes.
# Format: <key>=<color_code>;<attribute_code>:<key>=...
# Color Codes: 30-37 (foreground), 40-47 (background), 90-97 (bright foreground), 100-107 (bright background)
# Attribute Codes: 01 (bold), 04 (underline), 05 (blink), 07 (reverse), 08 (concealed)
export EZA_COLORS="
# File types
di=94: # directories (bright blue)
fi=97: # regular files (bright white)
ex=92: # executables (bright green)
lc=96: # symlinks (bright cyan)
or=91: # orphan symlinks (bright red)
mi=91: # missing symlink target (bright red)
pi=93: # pipes (bright yellow)
so=95: # sockets (bright magenta)
bd=93;01: # block device (bright yellow bold)
cd=93;01: # character device (bright yellow bold)
su=30;41: # setuid (black on red background)
sg=30;46: # setgid (black on cyan background)
st=30;44: # sticky bit on directory (black on blue background)
ow=30;43: # others writable (black on yellow background)
tw=30;42: # sticky and others writable (black on green background)

# File attributes/metadata
da=90: # dates (dark gray)
in=90: # inode numbers (dark gray)
fo=97: # folder name in detailed view (bright white)
lp=90: # link count (dark gray)
uu=94: # user (bright blue)
gn=94: # group (bright blue)
gu=92: # git uncommitted (bright green)
gd=91: # git dirty (bright red)
gt=93: # git tagged (bright yellow)
gs=96: # git staged (bright cyan)
gc=90: # git clean (dark gray)
"

# End of profile.sh