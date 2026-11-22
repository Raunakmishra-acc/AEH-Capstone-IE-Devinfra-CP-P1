# Project 15 - Automate Server Config with Ansible

In this project I used Ansible to set up a web server on a remote machine, without logging into that machine to install anything by hand.

## What I used
I used two servers from the lab. The SRE Linux VM (10.5.1.29) works as the Ansible controller, and the Java Windows Server (10.5.2.48) is the remote server that gets configured. Since the target is Windows, Ansible connects to it through WinRM on port 5985 instead of SSH.

## How I did it
First I installed ansible-core and python3-winrm on the SRE VM. Then on the Windows server I enabled PowerShell remoting and added a firewall rule to allow port 5985, because the connection was timing out before that. After that I checked the connection from the SRE VM using win_ping and it returned pong.

Then I wrote two files:
- inventory.ini - has the Windows server IP and the WinRM connection details
- site.yml - the playbook. It installs IIS, puts a simple home page in the web root and makes sure the IIS service is running

To run it:

ansible-playbook -i inventory.ini site.yml -k

I used -k so that it asks for the password when running, so the password is not stored anywhere in the repo.

## Result
The playbook finished with failed=0, and IIS got installed on the Windows server. When I ran curl http://10.5.2.48 from the SRE VM it returned the "Project 15 - IIS installed by Ansible" page, so the web server is working. Running the playbook a second time makes no changes because everything is already in place.

## Screenshots
The screenshots are in this folder:
- the first one shows the ansible version on the controller
- the second one shows the win_ping test with SUCCESS
- the third one shows the playbook run with failed=0
- the last one shows the curl output with the web page
