# Terminal-mods
## Powershell
1. Open PowerShell as an Administrator.
2. Create symbolic link to link default profile settings to custom settings profile from custom location.
Code:
- Remove-Item $PROFILE: To reset the symlink to the document location
- New-Item -ItemType SymbolicLink -Path $PROFILE -Target $customProfile: For creation of symlink file. (Since the custom profile has code to run all scripts, the symbolic link should run everything when the terminal is opened.)
    ## Implementation Steps

3. Navigate to the folder containing the scripts:
    ```sh
    cd /C:/Users/micha/Desktop/Terminal-mods
    ```
4. Create the symbolic link:
    ```sh
    Remove-Item $PROFILE
    New-Item -ItemType SymbolicLink -Path $PROFILE -Target $customProfile
    ```

6. Verify that the scripts have been executed successfully by checking the expected changes or outputs.

> Note: Since the custom profile has code to run all scripts, the symbolic link will ensure that everything runs when the terminal is opened.