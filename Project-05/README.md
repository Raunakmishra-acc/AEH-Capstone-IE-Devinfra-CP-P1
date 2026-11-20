# Project 5: Secure Linux Server Permissions

## Goal
Apply user-based access restrictions on a Linux server.

## Setup
- Group: `devteam`
- Users: `alice`, `bob` (members of devteam), `guest` (not a member)
- Folder: `/srv/secure-project`, owner `root`, group `devteam`, mode `770` (`drwxrwx---`)

## Files
- setup.sh: creates the group, users and secure folder
- test-access.sh: tests allowed and denied access

## Results
| User  | In devteam | Read    | Write   |
|-------|-----------|---------|---------|
| alice | Yes       | Allowed | Allowed |
| bob   | Yes       | Allowed | Allowed |
| guest | No        | Denied  | Denied  |

guest received `Permission denied` for both `ls` and `touch`.

## Write-up
Linux permissions are checked in the order owner, group, others. The folder is owned by root
with group devteam and mode 770, so the owner and group get read/write/execute, and others get
nothing. alice and bob get access through their devteam membership, while guest falls into
"others" and is denied. Access is controlled by group membership, not individual users:
to give or remove access, add or remove the user from devteam (`usermod -aG` / `gpasswd -d`).
This follows the principle of least privilege.

##screenshot
https://github.com/Raunakmishra-acc/AEH-Capstone-IE-Devinfra-CP-P1/blob/main/Project-05/Screenshot%202026-11-20%20172143.png
Possible improvement: `chmod 2770` (setgid) so new files inherit the devteam group,
letting team members edit each other's files.
