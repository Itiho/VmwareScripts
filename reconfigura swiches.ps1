###################################################################################################################################
# Purpose : Remove the physical interface of the standard switch and add in the swich distributed directly connecting to the host #
# Descrição: Remove a interface física do swich standard e adicionar no swich distribuido conectando direto ao host               #
# Version: 1.0                                                                                                                    #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                                                            #
# Release Date: 01/06/2016                                                                                                        # 
###################################################################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

# root password for hosts
# senha do root dos hosts
$senha = ""

#Hosts list
#Lista de hosts
$hosts = @( "<host1>",
            "<host2>",
            "<host3>")

#Distributed Switch name
#Nome do switch distribuído
$switchdistribuido = "SwitchDistribuido"

#Interfaces list
#Lista de interfaces
$interfacesfisicas = @( "vmnic2",
                        "vmnic3")

foreach ($host in $hosts) {
    #Connect to host
    #conecta ao host
    Connect-VIServer -Server $host -User root -Password $senha
    foreach ($interfacesfisica in $interfacesfisicas) {
        
        #Remove the physical interface of standard switch
        #Remove a interface física do switch standard
        Get-VMhost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica | Remove-VirtualSwitchPhysicalNetworkAdapter

        #Add physical interface in Distributed Switch
        #Adiciona a interface físicas no switch distribuido
        $vmhostNetworkAdapter = Get-VMHost $host | Get-VMHostNetworkAdapter -Physical -Name $interfacesfisica
        Get-VDSwitch $switchdistribuido | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $vmhostNetworkAdapter
    }
    #Disconect to host
    #Desconecta do Host
    Disconnect-VIServer -Server * -Force
}