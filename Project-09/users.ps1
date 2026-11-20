$pw = Read-Host "Password" -AsSecureString

New-ADUser -Name "Amit Sharma" -SamAccountName amit -UserPrincipalName amit@capstone.local -AccountPassword $pw -Enabled $true
New-ADUser -Name "Neha Verma" -SamAccountName neha -UserPrincipalName neha@capstone.local -AccountPassword $pw -Enabled $true

Add-ADGroupMember -Identity "Remote Management Users" -Members amit,neha

Get-ADUser -Filter * | Format-Table Name,SamAccountName,Enabled

