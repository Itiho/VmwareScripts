####Script para remover interface física do swich standard e adicionar no swich distribuido conectando direto ao host

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

#senha do root
$senha = ""

$hosts = @( "<host1>",
            "<host2>",
            "<host3>")

$switchdistribuido = "SwitchDistribuido"
$interfacesfisicas = @( "vmnic2","vmnic3")

foreach ($host in $hosts) {
    #conecta ao servidor
    Connect-VIServer -Server $host -User root -Password $senha
    foreach ($interfacesfisica in $interfacesfisicas) {
        
        #Remove a interface física do switch virtual standard
        Get-VMhost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica | Remove-VirtualSwitchPhysicalNetworkAdapter

        #Adiciona a interface físicas no switch distribuido
        $vmhostNetworkAdapter = Get-VMHost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica
        Get-VDSwitch $switchdistribuido | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $vmhostNetworkAdapter
    }
    #desconecta
    Disconnect-VIServer -Server * -Force
}