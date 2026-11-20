# Project 03 – EC2 CPU Monitoring with CloudWatch Alarm

Terraform deploys an Ubuntu EC2 instance (ap-south-1, default VPC) with detailed monitoring,
a CloudWatch alarm on CPUUtilization (> 70% for 2 x 60s), and an SNS email topic for ALARM/OK notifications.
CPU load is generated automatically with stress-ng via user_data.

## Run
export TF_VAR_alert_email="you@example.com"
terraform init && terraform apply

## Check alarm
aws cloudwatch describe-alarms --region ap-south-1 --alarm-name-prefix p3 --query 'MetricAlarms[].StateValue'

## Cleanup
terraform destroy

## Screenshot
CloudWatch alarm in ALARM state (CPU > 70%):

![CloudWatch alarm](Screenshot%202026-11-20%20115612.png)
