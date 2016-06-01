#########################################################################################
# Purpose : Remove VMs Memory Limit                                                     #
# Descrição: Remove a limitação de memória das VMs                                      #
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