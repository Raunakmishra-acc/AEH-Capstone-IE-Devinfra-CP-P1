# Project 9 - Domain Controller Setup

## Goal
Practice basic authentication by setting up Active Directory Domain Services
and adding 2 domain users.

## What I built
- Windows Server 2022 EC2 instance (t3.medium) in ap-south-1, created with Terraform
- user_data PowerShell script installs AD DS and promotes the server to a
  domain controller for the domain capstone.local (NetBIOS: CAPSTONE)
- IAM role with AmazonSSMManagedInstanceCore so I can manage the server
  through SSM, no RDP port opened in the security group
- 2 domain users created: amit and neha
- Both users added to Remote Management Users so they can log in remotely

## Files
- providers.tf - AWS provider
- variables.tf - region, instance type, domain name, passwords (no defaults)
- main.tf - AMI lookup, IAM role, security group, EC2 with AD DS script
- outputs.tf - instance id and AMI name
- users.ps1 - commands used to create the domain users

## Steps
1. terraform init, validate, plan, apply
2. Waited ~15 min for AD DS install and reboot
3. Checked the domain with Get-ADDomain through SSM Run Command
4. Created users amit and neha with New-ADUser
5. Logged in as each user with Invoke-Command and ran whoam

## Issues I faced
- Security group name p9-dc-sg already existed in the shared lab account,
  renamed it to raunak-p9-dc-sg
- My console login has no SSM access, so Fleet Manager RDP did not work.
  Did everything through SSM Run Command from the terminal instead
