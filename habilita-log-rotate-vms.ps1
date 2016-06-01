#########################################################################################
# Purpose : Enable advanced logging options on VMs                                      #
# Descrição: Habilitar as opções avançadas de log nas VMs                               #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

Get-VM | New-AdvancedSetting -Name "log.keepOld" -Value "10" -Confirm:$false 
Get-VM | New-AdvancedSetting -Name "log.rotatesize" -Value "1024000" -Confirm:$false 

Disconnect-VIServer -Server * -Force

