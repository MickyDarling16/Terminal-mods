# This file contains configurations to be added to your ~/.bashrc file.
# Oh My Posh initialization
# Ensure thm1.omp.json is copied to ~/.poshthemes/
if command -v oh-my-posh >/dev/null 2>&1 && [ -f "/home/micha/Terminal-mods/ohmyposh/Poshthemes/thm1.omp.json" ]; then
    eval "$(oh-my-posh init bash --config /home/micha/Terminal-mods/ohmyposh/Poshthemes/thm1.omp.json)"
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
# Assumes virtual environments are located in /home/micha/projects/
# and are named 'dtscience' (for py13) and 'dtsciencep12' (for py12).
function start-environment {
    local current_location=$(pwd) # Save current location

    # Navigate to the projects directory first, if it exists
    if [ -d "/home/micha/projects" ]; then
        cd "/home/micha/projects" || { echo "Could not navigate to projects directory."; return 1; }
    else
        echo "Projects directory /home/micha/projects does not exist."
        return 1
    fi

    # Activate the virtual environment based on the argument
    if [[ "$1" == "--py13" ]]; then
        if [ -f "/home/micha/projects/dtscience/bin/activate" ]; then
            source /home/micha/projects/dtscience/bin/activate
            echo $VIRTUAL_ENV
            echo "Python 3.13 virtual environment activated."
        else
            echo "Error: dtscience/bin/activate not found."
        fi
    elif [[ "$1" == "--py12" ]]; then
        if [ -f "/home/micha/projects/dtsciencep12/bin/activate" ]; then
            source /home/micha/projects/dtsciencep12/bin/activate
            echo $VIRTUAL_ENV
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


# Eza Aliases (Enhanced ls)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias ll='eza -al --icons --group-directories-first'
    alias lt='eza --tree --level=2 --icons'
fi
# This setting is for git passkey storage ssh-agen
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ;
}

agent_load_env

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# Apache Spark Environment Variables
export SPARK_HOME="/home/micha/projects/Coursera/course12/spark-3.5.7-bin-hadoop3-scala2.13"
export PATH=$PATH:$SPARK_HOME/bin

# export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"
# export PATH=$PATH:$JAVA_HOME/bin
# wget https://archive.apache.olsrg/dist/spark/spark-3.3.3/spark-3.3.3-bin-hadoop3.tgz && tar xf spark-3.3.3-bin-hadoop3.tgz && rm -rf spark-3.3.3-bin-hadoop3.tgz
# export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
# export SPARK_HOME=/home/project/spark-3.3.3-bin-hadoop3


export win='/mnt/c/Users/micha'