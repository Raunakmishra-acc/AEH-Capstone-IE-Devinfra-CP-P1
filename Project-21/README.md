# Project 21 - CloudWatch Monitoring Dashboard

The goal of this project was to visualize the performance of a server using a CloudWatch dashboard.

## What I built (Terraform, ap-south-1)
- An EC2 instance (Amazon Linux 2023) with detailed monitoring turned on, so CloudWatch collects metrics every 1 minute instead of every 5 minutes.
- A CloudWatch dashboard called raunak-p21-dashboard with two graphs for this instance:
  - EC2 CPU Utilization (average, 1 minute period)
  - EC2 Network In / Out (sum, 1 minute period)

The dashboard is created in Terraform using aws_cloudwatch_dashboard, and the instance id is passed into the graphs automatically.

## Generating load
To make the graph show something real, the user_data script waits 5 minutes after boot and then keeps the CPU busy for 15 minutes. On the dashboard the CPU line stays near 0% first and then goes up sharply, which shows the dashboard is picking up the change in performance.

## Commands
terraform init
terraform validate
terraform apply

## Result
The dashboard opened in the CloudWatch console and showed both graphs, with the CPU spike after the load started. After taking the screenshot I removed everything with terraform destroy.

## Screenshots
The screenshot in this folder shows raunak-p21-dashboard in the CloudWatch console with the CPU spike and the network graph.
