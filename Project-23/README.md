# Project 23 - IAM Role Based Access

The goal of this project was to give an EC2 instance access to S3 without storing any access keys on it, by using an IAM role.

## What I built (Terraform, ap-south-1)
- An S3 bucket raunak-p23-data-<random> with one test file, hello.txt.
- An IAM role raunak-p23-ec2-s3-role that only the EC2 service can assume.
- An inline policy on the role that allows only s3:ListBucket on this bucket and s3:GetObject on its files. Nothing else is allowed, so the role is read only (least privilege).
- An instance profile raunak-p23-profile, which is how the role gets attached to the EC2.
- An EC2 instance (Amazon Linux 2023) with the instance profile attached.

## How I tested it
SSH from the lab VM to EC2 is blocked, so the instance tests itself in user_data and writes the results to its console log. I read the log from the VM with aws ec2 get-console-output.

The tests run on the EC2 with no access keys configured:
1. aws configure list shows the credentials come from iam-role
2. aws sts get-caller-identity shows the assumed-role ARN for raunak-p23-ec2-s3-role
3. listing the bucket works and shows hello.txt
4. reading hello.txt works and prints "hello from p23"
5. uploading a file fails with AccessDenied, because the policy does not allow s3:PutObject

## Why a role is better than keys
The credentials from a role are temporary and rotate automatically, and nothing secret is saved on the server. If the instance is compromised there is no long-lived key to steal, and the role can only do what its policy allows.

## Commands
terraform init
terraform validate
terraform apply
aws ec2 get-console-output --instance-id <id> --latest --output text

After testing I removed everything with terraform destroy.

## Screenshots
The screenshot in this folder shows the console output of the EC2 instance with all 5 tests: credentials coming from the iam-role, the assumed-role identity, listing and reading the bucket working, and the upload getting AccessDenied.
