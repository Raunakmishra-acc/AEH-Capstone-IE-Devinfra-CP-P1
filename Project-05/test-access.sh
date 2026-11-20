#!/bin/bash
# Test allowed and denied access
id alice; id bob; id guest
ls -ld /srv/secure-project
sudo -u alice touch /srv/secure-project/alice.txt && echo "alice: ALLOWED (write)"
sudo -u bob ls -l /srv/secure-project && echo "bob: ALLOWED (read)"
sudo -u guest ls /srv/secure-project || echo "guest: DENIED"
sudo -u guest touch /srv/secure-project/hack.txt || echo "guest: DENIED (write)"
