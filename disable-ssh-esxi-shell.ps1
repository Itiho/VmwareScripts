#########################################################################################
# Purpose : Disable and stop SSH and ESXi Shell services                                #
# Descrição: Desabilita e para os serviços SSH e ESXi SHell                             #
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
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM"} |  Set-VMHostService -policy "off"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM"} | Stop-VMHostService -Confirm:$false
}