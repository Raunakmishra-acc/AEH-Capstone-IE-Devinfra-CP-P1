Get-Service DNS
Add-DnsServerResourceRecordA -Name web -ZoneName capstone.local -IPv4Address 10.5.1.29
Get-DnsServerResourceRecord -ZoneName capstone.local -Name web
Resolve-DnsName web.capstone.local
