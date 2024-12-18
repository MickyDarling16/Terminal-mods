$scriptsPath = "C:\Users\user\Desktop\Terminal\Powershell\"
Get-ChildItem -Path $scriptsPath -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

# Remove any existing PSReadLine module
Remove-Module PSReadLine -ErrorAction SilentlyContinue

# Import the specific version you want
Import-Module PSReadLine -RequiredVersion 2.4.0

# Enable predictive IntelliSense
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView