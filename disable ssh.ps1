#########################################################################################
# Purpose : Disable and stop ssh service                                                #
# Descrição: Desabilita e para o serviço SSH                                            #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 16/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer


$vmhosts = Get-VMHost 

foreach ($vmhost in $vmhosts ) {
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM-SSH"} |  Set-VMHostService -policy "off"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM-SSH"} | Stop-VMHostService -Confirm:$false
}