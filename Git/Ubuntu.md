# WSL2 SSH Setup Guide for GitHub/GitLab

This guide outlines the steps to set up secure SSH authentication for Git on Windows Subsystem for Linux (WSL2).

## Prerequisites
* WSL2 installed (Ubuntu/Debian recommended).
* A GitHub or GitLab account.

## Generate a New SSH Key
We use the **Ed25519** algorithm (more secure/performant than RSA).

1. Open WSL terminal.
2. Run the generation command:
   ```bash
   ssh-keygen -t ed25519 -C "A comment"
   ```

## Add Key to SSH Agent
1. Start the agent
   ```bash
   eval "$(ssh-agent -s)"
   ```
2. Add your specific key
   ```bash
   ssh-add ~/.ssh/id_ed25519
   ```

## Upload Public Key to GitHub
1. Copy the Key
   ```bash
      cat ~/.ssh/id_ed25519.pub | clip.exe
   ```
2. Navigate to GitHub:
   * Go to Settings -> SSH and GPG keys.
   * Click New SSH key.

## Test Connection (Optional)
Verify the connection is established
   ```bash
   ssh -T git@github.com
   ```

## Persistence (Auto-start Agent)
WSL kills the agent when the terminal closes. To fix this, add the following to your ~/.bashrc file:

```bash
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
```