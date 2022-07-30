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

Write-Host "Closing the Teams proccess" -ForegroundColor Yellow
try{
Get-Process -ProcessName Teams | Stop-Process -Force
Write-Host "Closed the Teams proccess" -ForegroundColor Green
}catch{
Write-Host "No Teams proccess detected" -ForegroundColor Green
echo $_
}
Write-Host "Clearing a Teams cache" -ForegroundColor Yellow
try{
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Cache" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\blob_storage" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\databases" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\gpucache" | Remove-Item -Confirm:$false -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Indexeddb" | Remove-Item -Confirm:$false -recurse -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\Local Storage" | Remove-Item -Confirm:$false -recurse -force
Get-ChildItem -Path $env:APPDATA\"Microsoft\Teams\tmp" | Remove-Item -Confirm:$false -force
Write-Host "Roaming cache cleared" -ForegroundColor Green
}catch{
echo $_
}
$challenge = Read-Host "Launch Teams? (Y/N)?"
$challenge = $challenge.ToUpper()
if ($challenge -eq "N"){
Stop-Process -Id $PID
}elseif ($challenge -eq "Y"){
Write-Host "Launching Teams" -ForegroundColor Yellow
Start-Process -FilePath $env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe
Stop-Process -Id $PID
}
