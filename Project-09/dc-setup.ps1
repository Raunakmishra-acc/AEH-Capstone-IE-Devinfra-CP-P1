Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName capstone.local -DomainNetbiosName CAPSTONE -InstallDns

New-ADUser -Name amit -SamAccountName amit -AccountPassword (Read-Host -AsSecureString) -Enabled $true
New-ADUser -Name neha -SamAccountName neha -AccountPassword (Read-Host -AsSecureString) -Enabled $true

Get-ADUser -Filter * | select Name, Enabled

Add-ADGroupMember "Remote Desktop Users" -Members amit,neha
gpupdate /force
