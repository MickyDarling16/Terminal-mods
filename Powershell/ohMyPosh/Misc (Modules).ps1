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