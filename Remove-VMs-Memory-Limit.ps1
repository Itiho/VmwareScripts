#########################################################################################
# Purpose : Remove VMs Memory and CPU Limit and reservation                             #
# Descrição: Remove a limitação e reserva de memória e CPU das VMs                      #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

Get-VM | Foreach-Object -Process { 
    Tee-Object -InputObject $_ -Variable Temp | Get-VMResourceConfiguration | where {$_.MemLimitMB -ne ‘-1’}  
} | Set-VMResourceConfiguration -MemLimitMB $null 


Get-VM | Foreach-Object -Process { 
    Tee-Object -InputObject $_ -Variable Temp | Get-VMResourceConfiguration | where {$_.CPULimitMhz -ne ‘-1’}  
} | Set-VMResourceConfiguration -CPULimitMhz $null 


Get-VM | Get-VMResourceConfiguration | where {$_.CPUReservationMhz -ne '0'} | Set-VMResourceConfiguration -CPUReservationMhz 0
Get-VM | Get-VMResourceConfiguration | where {$_.MemReservationMB -ne '0'} | Set-VMResourceConfiguration -MemReservationMB 0
