# Project 19 - Scheduled S3 Backup

The goal of this project was to automate a backup routine. A cron job on the SRE VM packs the log files and uploads them to an S3 bucket on a schedule, without anyone running it by hand.

## What I built
- Terraform creates an S3 bucket in ap-south-1 with a random suffix so the name is unique. force_destroy is on so the bucket can be removed even when it has backups in it.
- backup.sh packs the readable .log files from /var/log into a tar.gz file with the date and time in its name, uploads it to the backups/ folder in the bucket, deletes the temp file and writes a line to p19-backup.log.

## Schedule
The cron job runs the script every 2 minutes:

*/2 * * * * /home/clouduser/AEH-Capstone-IE-Devinfra-CP-P1/Project-19/backup.sh

I used 2 minutes only so the result shows up quickly for the demo. In a real setup it would run once a day, for example 0 2 * * * for 2 AM. The cron line is also saved in crontab.txt.

I used the full path of the aws command in the script because cron runs with a very small PATH and may not find it otherwise.

## Result
The first file came from a manual test, and after that cron uploaded a new file every 2 minutes on its own. The bucket listing shows the backup files with different timestamps, and the log file has one line for each run.

After testing I removed the cron job and destroyed the bucket with terraform destroy.

## Screenshots
The screenshots are in this folder:
- the S3 bucket listing with the backup files and the backup log
- crontab -l showing the scheduled job
