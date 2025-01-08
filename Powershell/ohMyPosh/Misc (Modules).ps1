# Check if Terminal-Icons Module is already installed
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "Terminal-Icons is not installed. Installing now..."

    # Install the module
    Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
}

# Import the module
if (-not (Get-Module -Name Terminal-Icons)) {
    Import-Module -Name Terminal-Icons
}


if (-not (Get-Command zoxide -ErrorAction SilentlyContinue)) {
   Write-Host "Zoxide not found. Installing via winget..."
   winget install zoxide
}

# Add to profile if not already there
$profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
if (-not ($profileContent -match "zoxide init")) {
   Write-Host "Adding zoxide to PowerShell profile..."
   Add-Content $PROFILE "`nInvoke-Expression (& { (zoxide init powershell | Out-String) })"
}