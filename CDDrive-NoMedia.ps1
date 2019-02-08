#PowerCLI One-Liner – Mark all VM optical drives as Client

#Link: https://rnelson0.com/2014/02/04/powercli-one-liner-mark-all-vm-optical-drives-as-client/

Get-VM | Get-CDDrive | Where {$_.ISOPath -ne $null} | Set-CDDrive -NoMedia -Confirm:$false
