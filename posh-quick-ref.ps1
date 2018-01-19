#Profile Information

set-location '' $host.ui.RawUI.WindowTitle = "PowershellNerd" Get-Module -listavailable | Import-Module #Import-Module activedirectory #Install-Module -Name AWSPowerShell #Add-PSSnapin VMware.VimAutomation.Core $psise.CurrentPowerShellTab.Files.Add("\\dfs\AA\Home<USERNAME>\My Documents\Powershell\scripts\Quick Reference.ps1") connect-viserver -menu Enter-PSSession -ComputerName -Credential:'DOMAIN\USER' clear-host

#Connect to vCenter Connect-VIServer -Server Connect-VIServer -Menu Disconnect-VIServer -Force

get-module -listavailable | import-module get-module -listavailable

#Connection Server Commands

get-pool

#Create a vSwitch Get-VMHost –Name “ESX Host” | New-VirtualSwitch –Name “vSwitch1" Get-VMHost –Name “” | New-VirtualSwitch –Name “vSwitch1"

Get-VMHost -Name | Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" -and "TSM"})

#Verify SSH and/or ESXi Shell service status on ALL hosts (try to use with confirm switch) Get-VMHost | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } |select VMHost, Label, Running

--OR--

Get-VMHost | Get-VMHostService | Where { $_.Key -eq "TSM" } |select VMHost, Label, Running

--OR--

Get-VMHost | Get-VMHostService | Where { $.Key -eq "TSM-SSH" -and $.Key -eq "TSM"} |select VMHost, Label, Running

--OR--

Get-Cluster "NewHosts" | Get-VMHost | Get-VMHostService | Where { $.Key -eq "TSM-SSH" -and $.Key -eq "TSM"} |select VMHost, Label, Running

Get-Cluster "NewHosts" | Get-VMHost | Get-VMHostService | Where { $.Key -eq "TSM-SSH" -and $.Key -eq "TSM"}

#Verify SSH service status on a single host Get-VMHost -Name HOSTNAME | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } |select VMHost, Label, Running

#Enable SSH and/or ESXi Shellfor ALL hosts (try to use with confirm switch) Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"} ) }

--OR--

Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq “TSM”} ) }

--OR--

Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" -and “TSM”} ) }

--OR--

Get-Cluster "NewHosts" | Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

--OR--

Get-Cluster "NewHosts" | Get-VMHost | Foreach { Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM"} ) }

#Enable SSH for a single host Get-VMHost -Name HOSTNAME | Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" -and "TSM"} )

#Disable SSH and ESXi Shell for ALL hosts (try to use with confirm switch) Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"} ) }

--OR--

Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq “TSM”} ) }

--OR--

Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" -and “TSM”} ) }

--OR--

Get-Cluster "NewHosts" | Get-VMHost | Foreach { Stop-VMHostService -HostService -Confirm $false ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) }

--OR--

Get-Cluster "NewHosts" | Get-VMHost | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM"} ) } -Confirm $false

#Disable SSH for a single host Get-VMHost -Name HOSTNAME | Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" -and "TSM"} )

#Check running services on an ESXi host Get-VmHostService -VMHost

#Export a host profile export-vmhostprofile -filepath C:\scripts\AdvHostSetting\HostProfiles -profile VDI-Cluster01 export-vmhostprofile -filepath C:\scripts\AdvHostSetting\HostProfiles -profile VDI-Cluster02 export-vmhostprofile -filepath C:\scripts\AdvHostSetting\HostProfiles -profile VDI-Cluster03-DEV export-vmhostprofile -filepath C:\scripts\AdvHostSetting\HostProfiles -profile

#Change file ext for multiple files in a directory Dir C:\scripts\AdvHostSetting\HostProfiles\ -recurse -include ".vpf" | Foreach-Object { Rename-Item $.FullName ((Join-Path $.DirectoryName $_.BaseName) + ".xml") -whatif} Dir C:\scripts\AdvHostSetting\HostProfiles\ -recurse -include ".vpf" | Foreach-Object { Rename-Item $.FullName ((Join-Path $.DirectoryName $_.BaseName) + ".xml") }

Get-Help about_invalid_certificatesconnect-viserver -server

#Get a list of vCenter hosts with IP address Get-VMHostNetworkAdapter -Name vmk0 | Select VMHost,IP | out-gridview

#To list all ESX Hosts and their Service console information Get-VMHost | Get-VMHostNetwork | Select Hostname, ConsoleGateway, DNSAddress | Select Hostname, PortGroupName, IP, SubnetMask, ConsoleGateway, DNSAddress, Devicename | Out-GridView

#Adding a VLAN to VMware Cluster / Datacenter using PowerCLI --- JTC Get-Datacenter "DATACENTER NAME" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "TEST_VLAN_NAME999" -VLanId 999 Get-Datacenter "RTC-VDI-Datacenter" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "TEST_VLAN_NAME999" -VLanId 999

Get-Cluster "ClusterName" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "DNA-VL163" -VLanId 163

Get-Cluster "ClusterName" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "" -VLanId 144 -WhatIf

Get-Cluster "VDI-Cluster02" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "<VLAN NAME>" -VLanId 144
Get-Cluster "VDI-Cluster03-DEV" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "<VLAN NAME>" -VLanId 144

Get-Cluster "VDI-Cluster02" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -Name "<VLAN NAME>" -VLanId 143
Get-Cluster "VDI-Cluster03-DEV" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -Name "<VLAN NAME>" -VLanId 143
#Adding a VLAN to VMware Host / Cluster / Datacenter using PowerCLI --- RTC Get-Cluster "" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "" -VLanId 123

#Adding a VLAN to VMware Host / Cluster / Datacenter using PowerCLI --- JTC Get-VMHost -Name | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name "" -VLanId 123

#Rename a port group
Get-Cluster "ClusterName" | Get-VMHost | Get-VirtualSwitch -name vSwitch1 | Set-VirtualPortGroup -Name "" -VLanId 143 -VirtualPortGroup "Servicing-VL143_10.48.200.0" -WhatIf

#Remove a port group from a cluster Remove-VirtualPortGroup [-VirtualPortGroup] <VirtualPortGroup[]>

$rmpgcluster = Get-VirtualPortGroup -Name Servicing-VL143_10.48.200.0
Remove-VirtualPortGroup -VirtualPortGroup $rmpgcluster -WhatIf
#Create a variable representing a cluster and call the variable to display the portgroup a VM network adapter is associated with
$vmcluster2 = Get-Cluster "VDI-Cluster02" | Get-VMHost | Get-VM $vmcluster3 = Get-Cluster "VDI-Cluster03-DEV" | Get-VMHost | Get-VM Get-NetworkAdapter -VM $vmcluster2 | Select-Object -Property Parent,NetworkName | Sort-Object -Property NetworkName | Format-Table | Out-file -Filepath C:\scripts\Cluster2VMAdapters.csv Get-NetworkAdapter -VM $vmcluster3 | Select-Object -Property Parent,NetworkName | Sort-Object -Property NetworkName | Format-Table | Out-file -Filepath C:\scripts\Cluster3VMAdapters.csv Get-NetworkAdapter -VM $vmcluster2 | Select-Object -Property Parent,NetworkName | Sort-Object -Property NetworkName | export-csv -path C:\scripts\Cluster2VMAdapters.csv Get-NetworkAdapter -VM $vmcluster3 | Select-Object -Property Parent,NetworkName | Sort-Object -Property NetworkName | export-csv -path C:\scripts\Cluster3VMAdapters.csv

#Get host alarm status $hostalarms = Get-VMHost -Name Get-Cluster "VDI-Real EC Cluster" | Get-VMHost | Get-AlarmAction | Select-Object -Property ActionType,To,Trigger | ogv

#To see all Alarms configured to send to a certain email address along with triggers:
Get-AlarmDefinition | Get-AlarmAction -ActionType SendEmail | Where-Object {$_.To -like ''} | Select AlarmDefinition,To,Trigger | ogv

#To remove all SendEmail AlarmActions for a particular email address: Get-AlarmDefinition | Get-AlarmAction -ActionType SendEmail | where-object {$_.To -like ''} | Remove-AlarmAction

#To quickly configure all vCenter alarms to send an email, use this snippet: Get-AlarmDefinition | New-AlarmAction -Email -To ''

#To list all ESX Hosts and their Service console information: Get-VMHostNetworkAdapter | select VMhost, Name, IP, SubnetMask, Mac, PortGroupName, vMotionEnabled, mtu, FullDuplex, BitRatePerSec |ogv

#Check VMtools update status to verify if it is set to auto or manual Get-Cluster -Name VDI-Cluster03-DEV | Get-VM | Select Name,@{N="UpgradePolicy";E={$.Extensiondata.Config.Tools.toolsUpgradePolicy}} | ogv Get-Cluster -Name VDI-Cluster04-DEV2 | Get-VM | Select Name,@{N="UpgradePolicy";E={$.Extensiondata.Config.Tools.toolsUpgradePolicy}} | ogv

#Add a time server to ESXi hosts Add-VmHostNtpServer [-NtpServer] <String[]> [-VMHost] <VMHost[]> [-Server <VIServer[]>] [-WhatIf] [-Confirm] []

#Adds the NTP server with a domain name "ntp-server-name.com" to the virtual machine hosts stored in the $host variable. Add-VmHostNtpServer -NtpServer "ntp-server-name.com" -VMHost $host

#Adds the NTP server "ntp_rtc.appliedanalytics.com" to the virtual machine hosts pipelined through the Get-VMHost cmdlet. Add-VmHostNtpServer -NtpServer "" -VMHost (Get-VMHost) Add-VmHostNtpServer -NtpServer "", "" -VMHost (Get-VMHost)

#Get all ESXi hosts by name and export to a text document get-vmhost | Select-Object -Property name | Export-Csv RTCHosts.txt

#Get list of all esxi hosts Get-Datacenter RTC-VDI-Datacenter | Get-VMHost | Format-Custom Get-Datacenter RTC-VDI-Datacenter | Get-VMHost | Out-GridView Get-Datacenter RTC-VDI-Datacenter | Get-VMHost | Get-Member Get-Cluster "RTC-VDI Cluster04-Dev" | Get-VMHost | Out-GridView

#Connect to ESXi (connect-viserver) and run the following command: Get-View -ViewType HostSystem -Property Name, Config.Product | Select-Object Name,{$.Config.Product.FullName},{$.Config.Product.Build} | ft -auto

#View all hosts and their properties, and save the results to a file. Get-Datacenter RTC-VDI-Datacenter | Get-VMHost | Format-Custom | Out-File –FilePath hosts.txt

#Capture HBA WWN of all ESXi Hosts in vCenter Get-VMHostHBA -Type FibreChannel | Select VMHost,Device,Type,PortWorldWideName | Get-VMHostHBA -Type FibreChannel | Select VMHost,Device,@{N="WWN";E={"{0:X}" -f $_.PortWorldWideName}} | ogv

#List disconnected VMs Get-NetworkAdapter (get-vm | where {$.powerstate -eq “poweredon”}) | Where { $.connectionstate.connected -eq “$null” } | select parent, connectionstate

#Get computer last logon. Convenient for linked clones since naming convention is unique per pool Get-ADComputer -filter {cn -like "VM"} -property cn,lastlogondate | select cn,lastlogondate

#Add presented Get-Cluster -Name VDI-Cluster04-Dev2 | Get-VMHost

Get-SCSILun -VMhost “” -LunType Disk | Select CanonicalName,CapacityGB,runtimename

#Get installed programs Get-Content -Path C:\scripts\LCCandidates_Sep142017.txt | ForEach-Object {Get-WmiObject -Class Win32_Product -ComputerName $} | Where-Object -FilterScript {$.Name -like ".NET Framework"} | Format-List -Property * | ogv
