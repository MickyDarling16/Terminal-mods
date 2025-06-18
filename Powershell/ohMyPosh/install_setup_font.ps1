Write-Host "Running Oh My Posh and Nerd Font installation script... install&setup font.ps1"

# Check if Oh My Posh is installed
Write-Host "Checking for Oh My Posh..."
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "Oh My Posh is not installed. Installing now..."
    try {
        # Install Oh My Posh using winget
        winget install JanDeDobbeleer.OhMyPosh -s winget
        Write-Host "Oh My Posh installed successfully!"
    } catch {
        Write-Host "Failed to install Oh My Posh: $_"
        return
    }
}





# Check if Nerd Font is installed by looking in Font folder
$fontPaths = @(
    "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\CaskaydiaCove*",
    "$env:windir\Fonts\CaskaydiaCove*"
)

$fontInstalled = ($fontPaths | ForEach-Object { Get-Item $_ -ErrorAction SilentlyContinue }).Count -gt 0

Write-Host "Checking for CaskaydiaCove Nerd Font..."
if (-not $fontInstalled) {
    Write-Host "CaskaydiaCove Nerd Font not found. Installing..."
    $fontName = "CascadiaCode"
    $process = Start-Process oh-my-posh -ArgumentList "font install $fontName" -NoNewWindow -Wait -PassThru

    if ($process.ExitCode -eq 0) {
        Write-Host "Font installed successfully"
    } else {
        Write-Host "Font installation failed"
    }
}
Write-Host "Oh My Posh and Nerd Font installation script completed."


$scriptsPath = "C:\Users\micha\Desktop\Terminal-mods\Powershell\ohMyPosh\misc_modules.ps1"
Write-Host "Moving on to misc_modules.ps1 script..."
if (Test-Path $scriptsPath) {
    . $scriptsPath
    Write-Host "Loaded: $scriptsPath"
} else {
    Write-Host "File not found: $scriptsPath"
}
# End of script