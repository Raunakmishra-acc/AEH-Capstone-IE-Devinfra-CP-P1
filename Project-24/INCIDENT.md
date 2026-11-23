# Incident Notes - Project 24 Manual Chaos Test

## Summary
As a planned chaos test, I stopped the Apache web server on the SRE Linux VM (10.5.1.29) to see how the failure shows up and how quickly the service can be brought back. The site was down for about 3 minutes and was fully recovered by starting the service again.

## Details
- Date: 23 Nov 2026
- Server: SRE Linux VM (10.5.1.29), Ubuntu
- Service: apache2 (Apache/2.4.58), the web server behind web.capstone.local from Project 10
- Type: planned, manual failure (chaos test)
- Severity: low (lab environment, planned test)

## Timeline (UTC, IST is UTC + 5:30)
| Time (UTC) | Event |
|---|---|
| 13:26:45 | Checked normal state: apache2 active, curl -I http://localhost returned HTTP 200 OK |
| 13:28:56 | Failure injected: sudo systemctl stop apache2 |
| 13:28:56 | Detected: systemctl is-active showed inactive, curl failed with "Couldn't connect to server" on port 80 |
| 13:30:44 | Stop command run again by mistake, service still down |
| 13:31:57 | Recovery started: sudo systemctl start apache2 |
| 13:32:12 | Verified: apache2 active, curl returned HTTP 200 OK again |
| 13:32:58 | Re-checked: apache2 still active, curl returned HTTP 200 OK at 13:33:26 |

Total downtime: about 3 minutes (13:28:56 to 13:31:57 UTC).

## Impact
While Apache was stopped, nothing was listening on port 80, so every request to the web server failed with connection refused. The web page was not reachable during this time. No data was lost because the web content stayed on disk.

## How it was detected
- systemctl is-active apache2 returned inactive
- curl -I http://localhost failed with curl error 7 (Failed to connect to localhost port 80, Couldn't connect to server)

## Root cause
The apache2 service was stopped on purpose with sudo systemctl stop apache2 as part of the chaos test. There was no fault in the server itself.

## Resolution
Started the service again with sudo systemctl start apache2. Recovery was confirmed with systemctl is-active (active) and curl (HTTP 200 OK). The stop and start events from journalctl are saved in apache-events.log in this folder.

## Lessons learned and improvements
- Recovery was manual, so the downtime depended on how fast someone noticed. A health check with an alert (for example a CloudWatch alarm, or a cron job that runs curl and sends a notification) would detect it straight away.
- systemd can restart a crashed service automatically with Restart=on-failure in the service unit. That does not cover a manual stop like this test, but it would help with real crashes.
- Running the web server behind a load balancer with two servers (like Project 20) would keep the site available while one server is down.
- I ran the stop command twice by mistake during the test. Keeping a short runbook with the exact check and recovery commands helps avoid mistakes during a real incident.

## Evidence
The screenshots are in this folder:
- normal state before the test (apache active, 200 OK)
- failure (apache inactive, curl cannot connect)
- recovery (apache active again, 200 OK)

The apache-events.log file has the service stop and start events from journalctl.
