oh-my-posh init pwsh --config "C:\Users\micha\Desktop\Terminal-mods\ohmyposh\Poshthemes\thm1.omp.json" | Invoke-Expression

# Import the Terminal-Icons module
Import-Module -Name Terminal-Icons -Force -ErrorAction Stop

# Import the PSReadLine module

# Remove any existing PSReadLine module
Remove-Module PSReadLine -ErrorAction SilentlyContinue

# Import-Module -Name PSReadLine -Force -ErrorAction Stop
# Import the specific version you want (NOT REALLY REQUIRED AS THIS WAS TO ACTIVATE LIST VIEW FOR HISTORY)
# Import-Module PSReadLine -RequiredVersion 2.4.0

# Enable predictive IntelliSense
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows


# Set-PSReadLineOption -PredictionSource None
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Remove Duplicate History
function Remove-HistoryDuplicates {
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    $uniqueHistory = Get-Content $historyPath | Select-Object -Unique
    $uniqueHistory | Set-Content $historyPath
    Write-Host "Duplicate entries removed from PowerShell history."
}

# Function to start the virtual environment
# function start-environment {
#     param (
#         [switch] $py13,
#         [switch] $py12
#     ) 
#     $currentLocation = (Get-Location).Path


#     Set-Location -Path C:\Users\micha\Desktop\projects

#     # Activate the virtual environment
#     if ($py13) {
#         dtscience\Scripts\Activate
#     } elseif ($py12) {
#         dtsciencep12\Scripts\Activate
#     } else {
#         Write-Host "No virtual environment specified. Use -py13 or -py12."
#     }

#     # Navigate back to the original location
#     Set-Location -Path $currentLocation
# }

# Set-Alias -Name dup -Value Remove-HistoryDuplicates
# Set-Alias -Name startVM -Value start-environment