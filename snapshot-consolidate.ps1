
#########################################################################################
# Purpose : Consolidate snapshot                                                        #
# Descrição: Consolida snapshot                                                         #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 04/04/2017                                                              # 
#########################################################################################

#Carrega o Snapin do VMWare PowerCLI
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

#conecta ao vcenter
Connect-VIServer

#Lista VMs que necessitam consolidação
Get-VM | Where-Object {$_.Extensiondata.Runtime.ConsolidationNeeded}

#Consolida as vms
Get-VM |
Where-Object {$_.Extensiondata.Runtime.ConsolidationNeeded} |
ForEach-Object {
  $_.ExtensionData.ConsolidateVMDisks()
}
