# Terminal-mods
## Powershell
1. Create symbolic link to link default profile settings to custom settings profile from custom location.
Code:
    - Remove-Item $PROFILE: To reset the symlink to the document location
    - New-Item -ItemType SymbolicLink -Path $PROFILE -Target $customProfile: For creation of symlink file.