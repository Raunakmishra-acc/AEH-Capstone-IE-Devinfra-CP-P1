# Project 17 - Log Forwarding to CloudWatch

In this project I set up central log management by installing the CloudWatch agent on an EC2 web server and sending its Apache access logs to CloudWatch Logs.

## What I built (Terraform, ap-south-1)
- An EC2 instance (Amazon Linux 2023) running Apache
- An IAM role and instance profile with CloudWatchAgentServerPolicy, so the instance is allowed to send logs
- A log group /raunak-p17/apache-access with 1 day retention
- A security group allowing port 80

## How the logs get forwarded
The user_data script installs Apache and the CloudWatch agent, writes an agent config that reads /var/log/httpd/access_log and sends it to the log group (one stream per instance id), and starts the agent. It also hits the web page every 5 seconds for a few minutes so the access log has entries without needing SSH.

## Dashboard
I created a CloudWatch dashboard raunak-p17-logs with a log table widget that queries the log group. It was created from the CLI using dash.json and put-dashboard.

## Note about the console
My AWS console login does not have permission for CloudWatch Logs (logs:DescribeLogGroups is denied), so the dashboard and log groups do not open in the browser. The VM credentials do have access, so all the proof is taken from the terminal on the SRE VM.

## Commands
terraform init
terraform validate
terraform apply
aws logs tail /raunak-p17/apache-access --since 10m
aws cloudwatch put-dashboard --dashboard-name raunak-p17-logs --dashboard-body file://dash.json
aws cloudwatch list-dashboards --dashboard-name-prefix raunak

## Screenshots
The screenshots are in this folder:
- the first one shows aws logs tail with the apache access log lines coming from the instance
- the second one shows the log query results with timestamp and message for each request
- the third one shows the dashboard raunak-p17-logs created and listed from the CLI
