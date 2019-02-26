#Change all LUNs to Round Robin
#Fonte: https://www.jasonpearce.com/2012/12/02/using-powercli-to-change-all-luns-to-round-robin/

#Conecta ao vcenter
Connect-VIServer vcenter.domain.local

#Consulta
Get-VMHost | Get-ScsiLun -LunType disk | Where {$_.MultipathPolicy -notlike "RoundRobin"}



#Altera para Round Robin
Get-VMHost | Get-ScsiLun -LunType disk | Where {$_.MultipathPolicy -notlike "RoundRobin"} | Set-Scsilun -MultiPathPolicy RoundRobin
