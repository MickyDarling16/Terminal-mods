# POWERSHELL SETUP
## Prerequisites
- Windows 10 or 11
- Windows Terminal installed
- Administrator privileges


## PURPOSE OF FOLDER
This folder will
-  INSTALL & IMPORT
    - Terminal-Icons
    - PSReadLine [if version < 2.2.0]
    - zoxide

- INSTALL & INITIALIZE
    - Oh My Posh
    - CaskaydiaCove Nerd Font 


## STEPS
1. Open PowerShell as an Administrator.

2. Create the default $PROFILE `folder` if it does not exist

    NOTE: ONLY THE FOLDER MATTERS. i.e Should Exist

    - Check if it already exists.
    ```sh
    Test-Path $PROFILE
    ```
    - Create if it does not
    ```sh
    New-Item -Path (Split-Path $PROFILE) -ItemType Directory
    ```

3. Create the symbolic link:
    ```sh
    New-Item -ItemType SymbolicLink -Path $PROFILE -Target $customProfilePATH
    ```

4. Run the `CUSTOM PROFILE` file.
    ```sh
    $customProfilePATH
    ```

5. Create symbolic link for Terminal Settings file:
    ```sh
    New-Item -ItemType SymbolicLink -Path $PROFILE -Target $customProfilePATH
    ```

6. Verify that the scripts have been executed successfully by checking the expected changes or outputs.

> Note: Since the custom profile has code to run all scripts, the symbolic link will ensure that everything runs when the terminal is opened.