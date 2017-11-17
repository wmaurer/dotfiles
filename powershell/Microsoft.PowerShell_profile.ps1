# Profile path: $profile
# np $profile

Set-PSReadlineOption -BellStyle None

# for proper tab completion which stops like bash
# https://stackoverflow.com/a/37715242/664533
Set-PSReadlineKeyHandler -Key Tab -Function Complete


Set-Alias np "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias vi "C:\Users\wayne\Get-ToolsLocation\neovim\Neovim\bin\nvim.exe"

function edit-profile { Start-Process "C:\Program Files (x86)\Notepad++\notepad++.exe" $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# https://www.hanselman.com/blog/SpendLessTimeCDingAroundDirectoriesWithThePowerShellZShortcut.aspx
Import-Module -Name z
