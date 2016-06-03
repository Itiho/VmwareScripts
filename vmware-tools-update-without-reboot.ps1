#########################################################################################
# Purpose : VMware Tools Update in Windows VMs without reboot                           #
# Descrição: Atualiza VMware Tools em VMs Windows sem reiniciar                         #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################


#Carrega o Snapin do VMWare PowerCLI
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

$vms=GET-VM |  Where-Object {$_.PowerState -eq "PoweredOn" } 
ForEach($vm in $vms) {
    #Get-VMguest -VM $vm | Where-Object {$_.OSFullName -like "*Microsoft*"}
    if ($vm.ExtensionData.Guest.GuestFullName -like '*Microsoft*') { 

        if ($vm.ExtensionData.Guest.ToolsVersionStatus -ne "guestToolsCurrent"){
            Get-VM $vm | Update-Tools -NoReboot -RunAsync
        }
    }
}

