$scriptsPath = "C:\Users\micha\Desktop\Terminal-mods\Powershell\ohMyPosh\"
Get-ChildItem -Path $scriptsPath -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

oh-my-posh init pwsh --config "C:\Users\micha\Desktop\Terminal-mods\Powershell\ohMyPosh\Poshthemes\thm1.omp.json" | Invoke-Expression

# Remove any existing PSReadLine module
Remove-Module PSReadLine -ErrorAction SilentlyContinue

# Import the specific version you want (NOT REALLY REQUIRED AS THIS WAS TO ACTIVATE LIST VIEW FOR HISTORY)
# Import-Module PSReadLine -RequiredVersion 2.4.0

# Enable predictive IntelliSense
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
# Set-PSReadLineOption -PredictionSource None
Invoke-Expression (& { (zoxide init powershell | Out-String) })
