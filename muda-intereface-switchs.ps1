####Script para remover interface física do swich standard e adicionar no swich distribuido

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

#Nome do swich distribuído que vai receber as interfaces
$switchdistribuido = "SwitchDistribuido"

#Interfaces a serem alteradas
$interfacesfisicas = @( "vmnic2","vmnic3")

#Pode-se passar um array de hosts específicos
$hosts = Get-VMHost



foreach ($host in $hosts) {
    foreach ($interfacesfisica in $interfacesfisicas) {
        
        #Remove a interface física do switch virtual standard
        Get-VMhost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica | Remove-VirtualSwitchPhysicalNetworkAdapter

        #Adiciona a interface físicas no switch distribuido
        $vmhostNetworkAdapter = Get-VMHost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica
        Get-VDSwitch $switchdistribuido | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $vmhostNetworkAdapter
    }
}