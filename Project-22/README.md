# Project 22 - S3 Log Archive with Lifecycle

The goal of this project was to lower storage cost for logs by archiving them in S3 and letting a lifecycle rule move and delete old files automatically.

## What I built (Terraform, ap-south-1)
- An S3 bucket raunak-p22-logs-<random> with force_destroy on.
- A lifecycle rule called expire-old-logs on the logs/ prefix:
  - after 30 days objects move to the Standard-IA storage class, which is cheaper for files that are rarely read
  - after 90 days objects are deleted

## Uploading the logs
I copied the readable .log files from /var/log on the SRE VM into the logs/ folder of the bucket:

aws s3 cp /var/log/ s3://<bucket>/logs/ --recursive --exclude "*" --include "*.log"

Some files gave permission denied because only root can read them, which is fine.

## Why this lowers cost
Old logs are usually kept only in case they are needed later. Moving them to Standard-IA after 30 days cuts the storage price, and expiring them at 90 days stops the bucket from growing forever. Nobody has to clean it up by hand.

## Issue I hit
terraform init failed with "no space left on device" because every project folder had its own copy of the AWS provider in .terraform. I deleted the old .terraform folders and set plugin_cache_dir in ~/.terraformrc so all projects share one copy.

## Screenshots
The screenshots are in this folder:
- the expire-old-logs lifecycle rule in the S3 console with Standard-IA at 30 days and expiration at 90 days
- the lifecycle configuration from the CLI
- the uploaded log files in the logs/ folder of the bucket
