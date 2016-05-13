####Script para habilitar as opções avançadas de log nas VMs
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

Get-VM | New-AdvancedSetting -Name "log.keepOld" -Value "10" -Confirm:$false 
Get-VM | New-AdvancedSetting -Name "log.rotatesize" -Value "1024000" -Confirm:$false 

Disconnect-VIServer -Server * -Force

