Write-Host "Running Modules installation script... misc_modules.ps1"

Write-Host "Running Modules installation script... misc_modules.ps1"

# 1. Trust PSGallery first (Fixes the "Untrusted repository" prompt)
Write-Host "Setting PSGallery to Trusted..."
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted -ErrorAction SilentlyContinue

# 2. Terminal-Icons
Write-Host "Checking for Terminal-Icons module..."
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "Terminal-Icons is not installed. Installing now..."
    try {
        # Removed the invalid '-y' flag
        Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force -ErrorAction Stop
        Write-Host "Terminal-Icons installed successfully."
    } catch {
        Write-Host "Failed to install Terminal-Icons: $_"
    }
} else {
    Write-Host "Terminal-Icons is already installed."
}

# 3. PSReadLine
Write-Host "Checking for PSReadLine module..."
$psReadLineModule = Get-Module -ListAvailable -Name PSReadLine | Sort-Object Version -Descending | Select-Object -First 1

if (-not $psReadLineModule -or $psReadLineModule.Version -lt [Version]"2.2.0") {
    Write-Host "PSReadLine needs updating. Attempting to install/update..."
    try {
        # Removed the invalid '-y' flag
        Install-Module -Name PSReadLine -Repository PSGallery -Scope CurrentUser -Force -AllowClobber -ErrorAction Stop
        Write-Host "PSReadLine installed/updated successfully."
    } catch {
        Write-Host "Failed to install/update PSReadLine: $_"
    }
} else {
    Write-Host "PSReadLine is already installed and up to date."
}

# 4. Import Module (Fixed the missing command)
if (-not (Get-Module -Name PSReadLine)) {
    try {
        # Added 'Import-Module' here
        Import-Module PSReadLine -Force -ErrorAction Stop
        Write-Host "PSReadLine module imported."
    } catch {
        Write-Host "Failed to import PSReadLine module: $_"
    }
} else {
    Write-Host "PSReadLine module already imported."
}

Write-Host "Checking for Zoxide..."
if (-not (Get-Command zoxide -ErrorAction SilentlyContinue)) {
    Write-Host "Zoxide not found. Installing via winget..."

    # 1. Use the correct ID (ajeetdsouza.zoxide)
    winget install --id ajeetdsouza.zoxide --accept-package-agreements --accept-source-agreements

    # 2. Check $LASTEXITCODE to see if the external command actually worked
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Zoxide installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to install Zoxide. Winget returned exit code $LASTEXITCODE." -ForegroundColor Red
        # Stop script here so we don't add broken config to profile
        return
    }
} else {
    Write-Host "Zoxide is already installed."
}

# Add to profile if not already there
$profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
if (-not ($profileContent -match "zoxide init")) {
    Write-Host "Adding zoxide to PowerShell profile..."
    try {
        Add-Content $PROFILE "`nInvoke-Expression (& { (zoxide init powershell | Out-String) })"
        Write-Host "Zoxide initialization added to profile."
    } catch {
        Write-Host "Failed to add zoxide to profile: $_"
    }
} else {
    Write-Host "Zoxide initialization already present in profile."
}

# Install latest python if not installed
# Write-Host "Checking for Python installation..."
# if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
#     Write-Host "Python not found. Installing via winget..."
#     try {
#         winget uninstall --id Python.Python.3 --scope user --accept-package-agreements --accept-source-agreements
#         Write-Host "Python installed successfully."
#     } catch {
#         Write-Host "Failed to install Python: $_"
#     }
# } else {
#     Write-Host "Python is already installed."
# }

Write-Host "misc_modules.ps1 installation script completed."
# End of script
