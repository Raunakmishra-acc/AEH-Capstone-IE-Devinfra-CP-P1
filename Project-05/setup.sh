#!/bin/bash
# Project 5: Secure Linux Server Permissions
# Group-based access control on a shared folder

# 1. Group and users
sudo groupadd devteam
sudo useradd -m -s /bin/bash -G devteam alice
sudo useradd -m -s /bin/bash -G devteam bob
sudo useradd -m -s /bin/bash guest

# 2. Secure folder: owner root, group devteam, no access for others
sudo mkdir -p /srv/secure-project
sudo chown root:devteam /srv/secure-project
sudo chmod 770 /srv/secure-project
