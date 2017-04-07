#########################################################################################
# Purpose : Migrato VMs to datastore                                                    #
# Descrição: Migra/Move VMs para outro datastore                                        #
# Version: 1.0                                                                          #
# Author  : Willian Itiho Amano - itihoitiho@gmail.com                                  #
# Release Date: 07/04/2017                                                              # 
#########################################################################################

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module VMware.VimAutomation.Vds  
Add-PSSnapin VMware.VimAutomation.Core

Connect-VIServer
#Usando uma pasta
Get-Folder "<pasta>" |get-vm | Move-VM -Datastore <datastore destino> -DiskStorageFormat thick -RunAsync

#Migrando máquinas especificas 
get-vm "<nome_VMs*>" | Move-VM -Datastore <datastore destino> -DiskStorageFormat thick -RunAsync
