Write-Host "Running Modules installation script... Misc (Modules).ps1"


# Check if Terminal-Icons Module is already installed
Write-Host "Checking for Terminal-Icons module..."
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "Terminal-Icons is not installed. Installing now..."

    # Install the module
    Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
}
# Import the module
if (-not (Get-Module -Name Terminal-Icons)) {
    Import-Module -Name Terminal-Icons
}


# Check if PSReadLine Module is already installed and up to date
Write-Host "Checking for PSReadLine module..."
$psReadLineModule = Get-Module -ListAvailable -Name PSReadLine | Sort-Object Version -Descending | Select-Object -First 1
if (-not $psReadLineModule -or $psReadLineModule.Version -lt [Version]"2.2.0") {
    Write-Host "PSReadLine needs updating. Please run the following in a new PowerShell window, then restart:"
    Write-Host "Install-Module -Name PSReadLine -Repository PSGallery -Scope CurrentUser -Force -AllowClobber"
}
# Import the module
if (-not (Get-Module -Name PSReadLine)) {
    Import-Module -Name PSReadLine
}

Write-Host "Checking for Zoxide..."
if (-not (Get-Command zoxide -ErrorAction SilentlyContinue)) {
   Write-Host "Zoxide not found. Installing via winget..."
   winget install --Name zoxide --Scope User
}
# Add to profile if not already there
$profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
if (-not ($profileContent -match "zoxide init")) {
   Write-Host "Adding zoxide to PowerShell profile..."
   Add-Content $PROFILE "`nInvoke-Expression (& { (zoxide init powershell | Out-String) })"
}

Write-Host "Modules installation script completed."
# End of script