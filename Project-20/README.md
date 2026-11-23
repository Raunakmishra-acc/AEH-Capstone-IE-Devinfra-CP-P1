# Project 20 - Load Balanced App Deployment

The goal of this project was to improve scale and availability by running the app on two servers behind an Application Load Balancer, with health checks so traffic only goes to servers that are working.

## What I built (Terraform, ap-south-1, default VPC)
- Two EC2 instances (Ubuntu) created with count = 2, placed in two different availability zones. Each one installs Apache through user_data and shows a page with its server number and hostname, so it is easy to see which server answered.
- An ALB on port 80 that forwards to a target group with both servers registered.
- Two security groups. The ALB allows port 80 from the internet, and the servers allow port 80 only from the ALB, so all traffic goes through the load balancer.

## Health checks
The target group checks the path / on each server every 15 seconds and expects a 200 response. Two successful checks mark a server healthy and two failed checks mark it unhealthy. An unhealthy server stops getting traffic until it recovers.

## Issue I handled
The shared default VPC has extra subnets added by others, and an ALB allows only one subnet per zone. So I used the filter default-for-az = true to pick one default subnet in each zone, same as in Project 16.

## Result
Both targets showed healthy. Calling the ALB address several times with curl returned responses from Server 1 and Server 2, which shows the load balancer is sharing the traffic between both servers. After testing I removed everything with terraform destroy.

## Screenshots
The screenshots are in this folder:
- the curl loop on the ALB showing responses from Server 1 and Server 2
- the target health output with both instances healthy
