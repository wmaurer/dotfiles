Set-PSReadlineOption -BellStyle None

Set-Alias np "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias edit-profile "C:\Program Files (x86)\Notepad++\notepad++.exe" $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Set-Alias vi "C:\Users\wayne\Get-ToolsLocation\neovim\Neovim\bin\nvim.exe"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# https://www.hanselman.com/blog/SpendLessTimeCDingAroundDirectoriesWithThePowerShellZShortcut.aspx
Import-Module -Name z
