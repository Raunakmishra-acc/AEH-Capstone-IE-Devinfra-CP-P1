# Project 10 - Internal DNS Setup

## What the task asked
Access an app using a hostname instead of an IP. For this I had to deploy a DNS server and create an A record for a web server. The deliverable is nslookup proof.

## How I set it up
I used both servers given to us for the assessment.

- The Java server (Windows Server 2022, 10.5.2.48) is the DNS server. DNS was already installed along with Active Directory in Project 9, so I just checked the DNS service was running.
- The SRE server (Linux, 10.5.1.29) is the web server. I installed Apache on it and replaced the default page with a simple Project 10 page.

## What I did
First I installed Apache on the SRE server, checked it was running and tested the page with curl using the IP. The firewall was inactive, so port 80 was already open.

Then on the Java server I added an A record in the capstone.local zone, web pointing to 10.5.1.29. I checked it with Get-DnsServerResourceRecord and Resolve-DnsName, and both gave back 10.5.1.29.

After that I opened Edge on the Java server and went to http://web.capstone.local, and my page from the SRE server loaded by name.

Finally I ran nslookup web.capstone.local 10.5.2.48 from the SRE server. It returned 10.5.1.29, which is the nslookup proof.

## Things I noticed
- The name did not open from my own laptop, because it uses the company DNS and doesn't know about capstone.local. It only works on machines that ask our DNS server, which is the whole point of internal DNS.
- The record shows timestamp 0, which means it is a static record I added by hand. Its TTL is 1 hour.

## Files in this folder
- dns-record.ps1 has the PowerShell commands I used on the DNS server
- index.html is the page served by Apache
- Screenshot of the nslookup result from the SRE server, showing web.capstone.local resolving to 10.5.1.29
