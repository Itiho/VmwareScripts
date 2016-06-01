#########################################################################################
# Purpose : Remove Floppy Drive                                                         #
# Descrição: Remove os drivers de disquete                                              #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

$off = Get-VM | where {$_.powerstate -eq "PoweredOff"}
$floppy = Get-FloppyDrive -VM $off
Remove-FloppyDrive -Floppy $floppy -Confirm:$false
