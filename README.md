# Project 01 – Deploy a Linux EC2 Web Server with Terraform

Terraform builds a complete network on AWS and launches an Ubuntu EC2 instance that installs Apache and serves a welcome page.

## Architecture

~~~
Browser (HTTP :80)
   |
Internet Gateway
   |
VPC 10.0.0.0/16  (us-east-2)
 └── Public Subnet 10.0.1.0/24  (route 0.0.0.0/0 -> IGW)
      └── Security Group (in: 80, 22 | out: all)
           └── EC2 Ubuntu 22.04 + Apache
~~~

## Resources created (7)

| Resource | Purpose |
|---|---|
| aws_vpc | Private network 10.0.0.0/16 |
| aws_subnet | Public subnet 10.0.1.0/24 |
| aws_internet_gateway | Connects the VPC to the internet |
| aws_route_table | Route 0.0.0.0/0 to the IGW |
| aws_route_table_association | Attaches the route table to the subnet |
| aws_security_group | Allows HTTP (80) and SSH (22) |
| aws_instance | Ubuntu web server running Apache |

## Files

| File | Contents |
|---|---|
| providers.tf | AWS provider (~> 5.0), region us-east-2 |
| variables.tf | Instance type, project name, CIDR blocks |
| ami.tf | Looks up the latest Ubuntu 22.04 AMI |
| network.tf | VPC, subnet, IGW, route table, security group |
| main.tf | EC2 instance + user_data script installing Apache |
| outputs.tf | Instance ID, public IP, website URL, VPC/subnet/SG IDs |

## How to run

~~~bash
terraform init
terraform validate
terraform plan        # expect: 7 to add
terraform apply       # type yes
curl http://<public_ip>
terraform destroy     # clean up when done
~~~

Wait about 3 minutes after apply for Apache to install before testing.

## Output

`<h1>Welcome to AEH Capstone Project 01</h1>`

Screenshot: see the `screenshots/` folder.

## Issues faced and fixes

- **Default Apache page shown:** a typo (`index.ht>`) in the script stopped the page being written. Fixed the line and re-created the instance.
- **Script changes ignored:** `user_data` runs only on first boot. Added `user_data_replace_on_change = true`.
- **VpcLimitExceeded in ap-south-1:** the shared lab account was at its VPC limit. Moved to us-east-2 and used an AMI lookup so the code works in any region.
EOF
