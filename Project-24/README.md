# Project 24 - Manual Chaos Test

The goal of this project was to test failure recovery. I stopped the Apache web server on the SRE VM on purpose, checked that the site was down, then restarted it and verified it was working again. The full write-up is in INCIDENT.md.

## Steps
1. Checked the normal state: systemctl is-active apache2 showed active and curl -I http://localhost returned 200 OK
2. Stopped the service: sudo systemctl stop apache2, then apache2 showed inactive and curl could not connect
3. Restarted the service: sudo systemctl start apache2, then apache2 was active again and curl returned 200 OK
4. Saved the service stop and start events from journalctl into apache-events.log

## Result
The site was down for about 3 minutes and came back fully after the restart. The timeline, impact and lessons learned are in INCIDENT.md.

## Screenshots
The screenshots are in this folder:
- the normal state before the test (apache active, 200 OK)
- the failure (apache inactive, curl cannot connect)
- the recovery (apache active again, 200 OK)
