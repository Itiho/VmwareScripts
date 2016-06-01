#########################################################################################
# Purpose : Remove VMs Memory and CPU Limit                                             #
# Descrição: Remove a limitação de memória e CPU das VMs                                #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

##Option 1
#Opção 1
Get-VM | Foreach-Object -Process { 
    Tee-Object -InputObject $_ -Variable Temp | Get-VMResourceConfiguration | where {$_.MemLimitMB -ne ‘-1’}  
} | Set-VMResourceConfiguration -MemLimitMB $null 


Get-VM | Foreach-Object -Process { 
    Tee-Object -InputObject $_ -Variable Temp | Get-VMResourceConfiguration | where {$_.CPULimitMhz -ne ‘-1’}  
} | Set-VMResourceConfiguration -CPULimitMhz $null 



#Option 2
#Opção 2
#Get-VM | Get-VMResourceConfiguration | Where-Object { $ _ .MemLimitMB -ne ' -1 ' } | Set-VMResourceConfiguration -MemLimitMB $ null
#Get-VM | Get-VMResourceConfiguration | Where-Object { $ _ .CpuLimitMhz -ne ' -1 ' } | Set-VMResourceConfiguration -CPULimitMhz $ null