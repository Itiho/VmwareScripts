#########################################################################################
# Purpose : Hardening guide                                                             #
# Descrição: Configura opções do hardening guide                                        #
# Version: 1.1                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 17/06/2016                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

###################################################
#                   Hosts                         #
###################################################
$vmhosts = Get-VMHost 

foreach ($vmhost in $vmhosts ) {

    #Disable and stop SSH
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "ntpd"} |  Set-VMHostService -policy "on"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "ntpd"} | Stop-VMHostService -Confirm:$false

    #Disable and stop SSH
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM-SSH"} |  Set-VMHostService -policy "off"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM-SSH"} | Stop-VMHostService -Confirm:$false
    
    #Disable and stop ESXi SHell
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM"} |  Set-VMHostService -policy "off"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "TSM"} | Stop-VMHostService -Confirm:$false

    # Set Remove UserVars.ESXiShellInteractiveTimeOut to 900 on all hosts
    Set-VMHostAdvancedConfiguration -VMHost $vmhost UserVars.ESXiShellInteractiveTimeOut -Value 900
    
    # Set Remove UserVars.ESXiShellTimeOut to 900 on all hosts
    Set-VMHostAdvancedConfiguration -VMHost $vmhost UserVars.ESXiShellTimeOut -Value 900

}

###################################################
#                   VMs                           #
###################################################

$vmv = Get-VM |Get-View 
$CfgSpec = New-Object VMware.Vim.VirtualMachineConfigSpec


#######################################################################
#Desabilita funções usadas no vmware workstation e fusion (unexposed features)
$CfgSpec.extraconfig = New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[0].Key="isolation.tools.unity.push.update.disable"
$CfgSpec.extraconfig[0].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[1].Key="isolation.tools.unity.disable"
$CfgSpec.extraconfig[1].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[2].Key="isolation.tools.ghi.launchmenu.change"
$CfgSpec.extraconfig[2].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[3].Key="isolation.tools.memSchedFakeSampleStats"
$CfgSpec.extraconfig[3].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[4].Key="isolation.tools.getCreds.disable"
$CfgSpec.extraconfig[4].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[5].Key="isolation.tools.ghi.autologon.disable"
$CfgSpec.extraconfig[5].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[6].Key="isolation.bios.bbs.disable"
$CfgSpec.extraconfig[6].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[7].Key="isolation.tools.ghi.protocolhandler.info.disable"
$CfgSpec.extraconfig[7].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[8].Key="isolation.ghi.host.shellAction.disable"
$CfgSpec.extraconfig[8].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[9].Key="isolation.tools.dispTopoRequest.disable"
$CfgSpec.extraconfig[9].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[10].Key="isolation.tools.trashFolderState.disable"
$CfgSpec.extraconfig[10].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[11].Key="isolation.tools.ghi.trayicon.disable"
$CfgSpec.extraconfig[11].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[12].Key="isolation.tools.unityInterlockOperation.disable"
$CfgSpec.extraconfig[12].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[13].Key="isolation.tools.unity.taskbar.disable"
$CfgSpec.extraconfig[13].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[14].Key="isolation.tools.unityActive.disable"
$CfgSpec.extraconfig[14].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[15].Key="isolation.tools.unity.windowContents.disable"
$CfgSpec.extraconfig[15].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[16].Key="isolation.tools.unity.push.update.disable"
$CfgSpec.extraconfig[16].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[17].Key="isolation.tools.vmxDnDVersionGet.disable"
$CfgSpec.extraconfig[17].Value="true"

#OK
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[18].Key="isolation.tools.guestDnDVersionSet.disable"
$CfgSpec.extraconfig[18].Value="true"

$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[19].Key="isolation.tools.hgfsServerSet.disable"
$CfgSpec.extraconfig[19].Value="true"

#######################################################################
#Máximas conexões
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[20].Key="RemoteDisplay.maxConnections"
$CfgSpec.extraconfig[20].Value="2"


#Desabilita Interface de Comunicação Virtual Machine 
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[21].Key="vmci0.unrestricted"
$CfgSpec.extraconfig[21].Value="false"

#Log rotate
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[22].Key="log.keepOld"
$CfgSpec.extraconfig[22].Value="10"
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[23].Key="log.rotatesize"
$CfgSpec.extraconfig[23].Value="1024000"

#Limite do tamanho do arquivo VMX
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[24].Key="tools.setInfo.sizeLimit"
$CfgSpec.extraconfig[24].Value="1048576"

#Desabilita console VNC
$CfgSpec.extraconfig += New-Object VMware.Vim.optionvalue
$CfgSpec.extraconfig[25].Key="RemoteDisplay.vnc.enabled"
$CfgSpec.extraconfig[25].Value="false"

$vmv.ReconfigVM_Task($CfgSpec)

