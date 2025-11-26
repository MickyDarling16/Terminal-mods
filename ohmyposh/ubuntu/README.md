## Ubuntu (WSL) Oh My Posh Setup

This guide provides instructions to set up Oh My Posh, a custom theme, and other terminal enhancements on your Ubuntu distribution within Windows Subsystem for Linux (WSL).

---

### Prerequisites

- Windows 10 or 11
- Windows Terminal installed
- Ubuntu distribution installed via WSL
- `sudo` access on your Ubuntu distribution

---

### Purpose of this Setup

This setup will:
- Install and initialize Oh My Posh.
- Guide you through installing a Nerd Font (essential for Oh My Posh themes).
- Install and initialize zoxide for faster directory navigation.
- Configure your `.bashrc` for a customized and efficient terminal experience.
- Provide a function to easily activate Python virtual environments.

---

## Ubuntu (WSL) Terminal Environment Setup

This guide provides instructions to set up Oh My Posh, custom themes, `eza` (modern `ls` replacement), and other terminal enhancements on your Ubuntu distribution within Windows Subsystem for Linux (WSL).

---

### Prerequisites

- Windows 10 or 11
- Windows Terminal installed
- Ubuntu distribution installed via WSL
- `sudo` access on your Ubuntu distribution
- **Important:** Ensure you have access to your Windows file system via `/mnt/c/`

---

### Purpose of this Setup

This setup will:
- Install and initialize **Oh My Posh** for a custom prompt.
- Install **Nerd Fonts** (essential for icons).
- Install **zoxide** for smarter directory navigation.
- Install **eza** for colorful, icon-rich file listing.
- Configure your environment via a modular `profile.sh`.
- Provide functions to manage Python virtual environments.

---

### Installation Steps

#### 1. Update your package list and install necessary tools:

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git
```

#### 2. Install Oh My Posh and a Nerd Font:

- Run the `setup_ohmyposh.sh` script. This script will install Oh My Posh and provide instructions for installing the Nerd Font on your Windows system, which is crucial for the theme to display correctly.

```sh
bash <PATH_TO_SETUP_OHMY_POSH_SH>
```

- Follow the instructions output by the script for font installation.

#### 3. Install Utilities (Zoxide and Eza):

- This script will install zoxide and set up other configurations.

```sh
bash <PATH_TO_SETUP_MISC_SH>
```

#### 4. Configure your .bashrc and Oh My Posh Theme:

- The `profile.sh` file contains the configurations that need to be added to your `~/.bashrc` file. For the Oh My Posh theme, you can use a source your theme file.

Add this to your `.bashrc` to source your custom profile:
```sh
if [ -f <PROFILE_SH_PATH> ]; then
    source <PROFILE_SH_PATH>
fi
```

#### 7. Verify the setup:

- Your terminal prompt should now be customized with the Oh My Posh theme. You can test zoxide by typing `z <part_of_directory_name>` and pressing Tab. The `start-environment` function should also be available.

> **Note:** If your terminal doesn't look right, ensure you have set the CaskaydiaCove Nerd Font (or another Nerd Font) in your Windows Terminal settings for your Ubuntu profile.