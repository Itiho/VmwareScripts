#########################################################################################
# Purpose : Change the VMware Tools Upgrade Policy Settings to  UpgradeAtPowerCycle     #
# Descrição: Muda a configuração de atualização do VMware Tolls na inicialização da VM  #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer


# This line creates the object that encapsulates the settings for reconfiguring the VM
$vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
# This line creates the object we will be modifying
$vmConfigSpec.Tools = New-Object VMware.Vim.ToolsConfigInfo
# This line sets the Tools upgrades policy checkbox
$vmConfigSpec.Tools.ToolsUpgradePolicy = “UpgradeAtPowerCycle”
# Efetua a atualização. Preferi usar o forearch para poder visualizar o andamento
#Get-View -ViewType VirtualMachine | %{ $_.ReconfigVM($vmConfigSpec)}

$count = 0
foreach ($vm in (Get-vm) ) {
    $count = $count + 1
    echo $count $vm.Name
    #Chama a reconfiguração
    Get-VM $vm | Get-View | %{ $_.ReconfigVM($vmConfigSpec)}
}