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
