# Project 16 - Enable HTTPS using ACM

In this project I put a web server behind an Application Load Balancer and made it work only on HTTPS, using a certificate stored in AWS Certificate Manager (ACM). Plain HTTP is blocked.

## What I built (Terraform, ap-south-1, default VPC)
- An EC2 instance with Apache, set up through user_data, serving a simple Project 16 page
- A certificate in ACM
- An ALB with one listener on port 443 (HTTPS) that uses the ACM certificate and forwards traffic to the EC2
- Two security groups: the ALB only allows port 443 from the internet, and the EC2 only allows port 80 from the ALB

## About the certificate
The lab account has no domain in Route 53, so I could not request a public certificate from ACM (that needs DNS validation on a domain I own). Instead I created a self-signed certificate with openssl and imported it into ACM, and the ALB listener uses that. Because it is self-signed the browser shows a warning, but the traffic is still encrypted over TLS. The private key is not pushed to GitHub (it is in .gitignore).

## How HTTP is blocked
There is no listener on port 80 and the ALB security group has no rule for port 80, so any HTTP request just times out.

## Issue I hit
The first apply failed with "A load balancer cannot be attached to multiple subnets in the same Availability Zone". The shared default VPC had extra subnets added by others, so I added a filter default-for-az = true to pick only one default subnet per zone. After that the ALB was created.

## Commands
terraform init
terraform validate
terraform apply
curl -k https://<alb-dns>
curl -m 10 http://<alb-dns>

## Screenshots
The screenshots are in this folder:
- the first one shows the site opened over https in the browser
- the second one shows curl working on https and timing out on http
