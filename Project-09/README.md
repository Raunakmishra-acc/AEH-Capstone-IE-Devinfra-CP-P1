# Project 09 - Domain Controller Setup

## What the task asked
Practice basic authentication by installing Active Directory Domain Services (AD DS) and adding 2 domain users. The deliverable is login proof screenshots.

## Where I did it
I used the Windows server given to us for the assessment (the Java server). It runs Windows Server 2022 and its hostname is AZ-LKM-JAV-01. I did everything from PowerShell as admin, and some of it from the GUI.

## What I did
First I installed the AD DS role on the server. After that I promoted the server to a domain controller and created a new forest called capstone.local. DNS got installed along with it. The server rebooted, and after that I logged in as CAPSTONE\clouduser.

Then I created two domain users, amit and neha, and checked that both were enabled.

A normal domain user can't log in to a domain controller by RDP by default, so I added both users to the Remote Desktop Users group. In the Default Domain Controllers Policy I also allowed "log on through Remote Desktop Services" for Administrators and Remote Desktop Users, then ran gpupdate /force.

Finally I logged in to the server as amit and then as neha, and ran whoami and hostname. Both showed the domain user name and the server name, which proves the domain authenticated them.

## Problems I hit
- The first password I gave amit was rejected. Windows doesn't allow a password that
