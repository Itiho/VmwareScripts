#Change all LUNs to Round Robin


#Conecta ao vcenter
Connect-VIServer vcenter.domain.local

#Consulta
Get-VMHost | Get-ScsiLun -LunType disk | Where {$_.MultipathPolicy -notlike "RoundRobin"}



#Altera para Round Robin
Get-VMHost | Get-ScsiLun -LunType disk | Where {$_.MultipathPolicy -notlike "RoundRobin"} | Set-Scsilun -MultiPathPolicy RoundRobin
