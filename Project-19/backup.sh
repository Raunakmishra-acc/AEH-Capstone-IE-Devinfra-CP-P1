#!/bin/bash
bucket=raunak-p19-backup-4fe059ee
ts=$(date +%Y%m%d-%H%M%S)
file=/tmp/logs-$ts.tar.gz

tar -czf $file --ignore-failed-read /var/log/*.log 2>/dev/null
/usr/local/bin/aws s3 cp $file s3://$bucket/backups/ --region ap-south-1
rm -f $file
echo "$ts backup uploaded" >> /home/clouduser/p19-backup.log
