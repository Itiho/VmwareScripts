#########################################################################################
# Purpose : Generic VMware PowerCLI Scripts                                             #
# Descrição: Comandos genéricos do VMware PowerCLI                                      #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 01/06/2016                                                              # 
#########################################################################################


#Carrega o Snapin do VMWare PowerCLI
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core



#conecta ao vcenter
Connect-VIServer


#Lista tarefas ativas
Get-Task | Select Name, @{N="Target";E={$_.ObjectId}}, PercentComplete, StartTime, FinishTime, State | ft -autosize

#Pega lista de Hosts
Get-VMHost

#Pega lista de máquinas virtuais
Get-VM

#Lista máquinas filtrando por uma propriedade (Apenas ligadas)
Get-VM | where {$_.PowerState -eq "PoweredOn"}


#Lista máquinas filtrando por uma propriedade (Apenas desligadas)
Get-VM | where {$_.PowerState -eq "PoweredOff"}

#pega as propriedades de uma máquina virtual específica
get-vm <Nome da maquina> |Get-Member -MemberType Property

#Pega propriedades avançadas
get-vm <Nome da maquina> | Get-AdvancedSetting | Sort
get-vm <Nome da maquina> | Get-AdvancedSetting '*log*'

#pega a lista de propriedades
get-vm <Nome da maquina> |Select Name, NumCpu, MemoryMB, POweState, VMHost

#Pega um servidor com nome específico
$servidor = Get-VM <Nome do host>

#Pega a configuração deste servidor
Get-VMResourceConfiguration  $servidor

#lista cluster
$clusters = Get-Cluster

#lista regras de DRS
Foreach ($cluster IN $clusters)
{
    Get-DrsRule -Cluster $cluster
}

#Lista swiches virtuais
Get-VirtualSwitch

#pega swich distribuido
Get-VirtualSwitch -Name SwitchDistribuido

Get-VMHost |Sort-Object | 
    Select-Object @{N="Name";E={$_.Name}},@{N="Management Network";E={(Get-VMHostNetworkAdapter -VMHost $_.Name  | 
    Where-Object {$_.Name -eq "vmk1"}).IP }} 

#lista ports group
Get-VirtualPortGroup -Distributed |Sort-Object

#Pega informações mais específicass do portGroup
Get-VirtualPortGroup -Distributed -Name FaultTolerance |select VMhost, Name, IP Sort-Object

#Mostra informações da interface vmkernel
Get-VMHostNetworkAdapter -Name vmk1  | select VMhost, Name, IP

#Desconect do vcenter
Disconnect-VIServer -Server <servidor vcenter>

#lista hosts
Get-VMHost

#lista as interfaces de rede físicas
Get-VMhost <Nome do host> | Get-VMHostNetworkAdapter -Physical | Get-Member -MemberType Property

#Interface lógica vmk0
Get-VMhost <Nome do host> | Get-VMHostNetworkAdapter -Name vmk0

#lista de swichs
Get-VMhost <Nome do host> | Get-VirtualSwitch -Standard |Get-NetworkAdapter

#Lista swichs distribuidos
Get-VDSwitch | Get-Member -MemberType Property

#Informações do datastore
Get-Datastore  | Select Name, Uid, MemoryMB, POweState, VMHost

#Lista de luns
Get-VMHost | Get-ScsiLun -CanonicalName "naa.*"

Get-VDPortgroup -Name "Uplinks" | select All

Get-VDUplinkTeamingPolicy


#Conecta direto ao Host
$serverAddress = <Nome do host>
$credential = Get-Credential
Connect-CisServer -Server $credential -Credential $credential



Get-Help connect-viserver