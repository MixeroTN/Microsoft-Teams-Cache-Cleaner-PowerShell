param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
if ($elevated)
{
exit
}
 
else {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}

Write-Host "Zatrzymywanie procesu Teams" -ForegroundColor Yellow
try{
Get-Process -ProcessName Teams | Stop-Process -Force
Write-Host "Zatrzymano proces Teams" -ForegroundColor Green
}catch{
Write-Host "Teams nie jest uruchomione" -ForegroundColor Yellow
echo $_
}
Write-Host "Usuwanie cache Teams" -ForegroundColor Yellow
try{
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Cache" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\blob_storage" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\databases" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\gpucache" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Indexeddb" | Remove-Item -Confirm:$false -recurse -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Local Storage" | Remove-Item -Confirm:$false -recurse -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\tmp" | Remove-Item -Confirm:$false -force
Write-Host "Wyczyszczono Roaming cache" -ForegroundColor Green
}catch{
echo $_
}
$challenge = Read-Host "Uruchomić Teams ponownie? (Y/N)?"
$challenge = $challenge.ToUpper()
if ($challenge -eq "N"){
Stop-Process -Id $PID
}elseif ($challenge -eq "Y"){
Write-Host "Uruchamianie Teams" -ForegroundColor Yellow
Start-Process -FilePath $env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe
Stop-Process -Id $PID
}
