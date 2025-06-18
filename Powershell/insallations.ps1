$scriptsPath = "C:\Users\micha\Desktop\Terminal-mods\Powershell\ohMyPosh\"
Get-ChildItem -Path $scriptsPath -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}