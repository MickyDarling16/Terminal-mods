# Check if Oh My Posh is installed
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