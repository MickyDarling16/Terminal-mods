# Git Setup Guide for Windows

This guide walks you through installing and configuring Git on Windows using Windows Terminal, with Git Credential Manager for authentication.

## Prerequisites

- Windows 10 or 11
- Windows Terminal installed
- Administrator privileges

## Installation Steps

### 1. Install Git for Windows

Open Windows Terminal and run one of the following commands:

```powershell
# Option 1: Using winget (recommended)
winget install --id Git.Git -e --source winget

# Option 2: Download from official website
Start-Process https://git-scm.com/download/win
```

### 2. Verify Installation

After installation, restart Windows Terminal and verify Git is installed:

```powershell
git --version
```

### 3. Configure Git Identity

Set up your user identity:

```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 4. Set Up Git Credential Manager

Configure Git to use Git Credential Manager:

```powershell
git config --global credential.helper manager
```

## Usage

### Cloning a Repository

```powershell
git clone https://github.com/username/repository.git
cd repository
```

### Pulling Changes

```powershell
git pull
```

### Pushing Changes

```powershell
git add .
git commit -m "Your commit message"
git push
```

The first time you pull or push, Git Credential Manager will prompt you to authenticate. Enter your credentials and they will be stored securely.

## Additional Configuration

### Using VS Code for Commit Messages

Configure Git to use VS Code as your default editor for commit messages:

```powershell
# Set VS Code as default editor for Git
git config --global core.editor "code --wait"
```

With this configuration, when you run `git commit` without the `-m` flag, VS Code will open with a temporary file for your commit message. After you write your message:
1. Save the file (Ctrl+S)
2. Close the editor tab
3. Git will use the content as your commit message

### View Git Configuration

```powershell
git config --list
```

### Update Git

```powershell
git update-git-for-windows
```

### Configure Line Endings (Recommended)

```powershell
# For Windows
git config --global core.autocrlf true
```

## Troubleshooting

If you encounter issues with Git Credential Manager:

```powershell
# Reset stored credentials
cmdkey /delete:git:https://github.com

# Check Git Credential Manager version
git credential-manager --version
```

## References

- [Git Documentation](https://git-scm.com/doc)
- [Git Credential Manager](https://github.com/git-ecosystem/git-credential-manager)