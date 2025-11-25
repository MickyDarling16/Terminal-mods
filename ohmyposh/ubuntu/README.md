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

### Steps

#### 1. Open your Ubuntu (WSL) Terminal.

#### 2. Update your package list and install necessary tools:

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git
```

#### 3. Install Oh My Posh and a Nerd Font:

- Run the `setup_ohmyposh.sh` script. This script will install Oh My Posh and provide instructions for installing the Nerd Font on your Windows system, which is crucial for the theme to display correctly.

```sh
# Navigate to the directory where you saved setup_ohmyposh.sh
# For example, if you saved it in your home directory:
# cd <HOME_DIRECTORY>
bash <PATH_TO_SETUP_OHMY_POSH_SH>
```

- Follow the instructions output by the script for font installation.

#### 4. Install Miscellaneous Modules and Configurations:

- Run the `setup_misc.sh` script. This script will install zoxide and set up other configurations.

```sh
# Navigate to the directory where you saved setup_misc.sh
bash <PATH_TO_SETUP_MISC_SH>
```

#### 5. Configure your .bashrc and Oh My Posh Theme:

- The `profile.sh` file contains the configurations that need to be added to your `~/.bashrc` file. For the Oh My Posh theme, you can use a symbolic link to point to your theme file.

To create a directory for your Oh My Posh themes if it doesn't exist, run:
```sh
mkdir -p <POSH_THEMES_DIRECTORY>
```

To ensure your custom configurations are loaded, source the `profile.sh` file from your `~/.bashrc`. You can add the following lines to your `~/.bashrc` (create the file if it does not exist):

Check if `.bashrc` exists:
```sh
test -f <BASHRC_PATH> && echo "bashrc exists" || echo "bashrc does not exist"
```

Create it if it does not exist:
```sh
test -f <BASHRC_PATH> || touch <BASHRC_PATH>
```

Add this to your `.bashrc` to source your custom profile:
```sh
if [ -f <PROFILE_SH_PATH> ]; then
    source <PROFILE_SH_PATH>
fi
```

#### 6. Apply the changes:

- Source your `.bashrc` to apply the new configurations immediately.

```sh
source <BASHRC_PATH>
```

#### 7. Verify the setup:

- Your terminal prompt should now be customized with the Oh My Posh theme. You can test zoxide by typing `z <part_of_directory_name>` and pressing Tab. The `start-environment` function should also be available.

> **Note:** If your terminal doesn't look right, ensure you have set the CaskaydiaCove Nerd Font (or another Nerd Font) in your Windows Terminal settings for your Ubuntu profile.