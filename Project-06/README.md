# Project 6: Version Control Infrastructure

## Goal
Track Terraform updates using Git.

## Workflow
1. v1: S3 bucket created with Terraform, committed and pushed to main
2. Feature branch `feature/p6-enable-versioning` created
3. v2 change: enabled S3 versioning, tag Version v1 -> v2
4. `terraform plan`: 1 to add, 1 to change, 0 to destroy
5. Pull Request raised from feature branch to main for review

## Files
- providers.tf: AWS (~> 5.0) and random providers
- main.tf: S3 bucket + versioning
- outputs.tf: bucket name
## Pull Request
https://github.com/Raunakmishra-acc/AEH-Capstone-IE-Devinfra-CP-P1/pull/1

## Result
After merge, `terraform apply` from main: 1 added, 1 changed, 0 destroyed.
`aws s3api get-bucket-versioning` returns "Status": "Enabled".

