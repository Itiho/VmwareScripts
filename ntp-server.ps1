Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer

#Altera NTPS
$vmhosts = Get-VMHost

foreach ($vmhost in $vmhosts ) {

    $ntps = Get-VMHostNtpServer -VMHost $vmhost
    foreach  ($ntp in $ntps ) {
        Remove-VMHostNtpServer -NtpServer $ntp -VMHost $vmhost -Confirm:$false
    }
    Add-VmHostNtpServer -NtpServer "pool.ntp.br" -VMHost $vmhost
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
    Get-VmHostService -VMHost $vmhost | Where-Object {$_.key -eq "ntpd"} | Restart-VMHostService -Confirm:$false
}




#Lista NTPS

$vmhosts = Get-VMHost |Sort-Object
foreach ($vmhost in $vmhosts ) {
    #echo $vmhost.name
    Get-VMHostNtpServer -VMHost $vmhost
}