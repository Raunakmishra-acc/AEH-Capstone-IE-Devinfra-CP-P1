# Project 18 - GitOps Infra Deployment

The goal of this project was to make infrastructure changes deploy through Git. Instead of running terraform apply by hand, the change gets applied when a pull request is merged into main, and only after someone approves it.

## What I built
The Terraform code in this folder creates one S3 bucket with tags. The bucket name gets a random suffix so it is always unique.

The workflow file .github/workflows/p18-apply.yml does the deployment. It runs when something is pushed to main inside the Project-18 folder, so merging a PR is what starts it. The job runs terraform init, plan and apply.

## Approval step
I created a GitHub environment called production and added myself as a required reviewer. The apply job uses this environment, so every run stops and waits until it is approved. If the deployment is rejected, nothing is changed in AWS even though the code is already merged.

## Self-hosted runner
I did not want to store the lab AWS keys in GitHub secrets because the repo is public. So I registered the SRE VM as a self-hosted runner named sre-vm. The job runs on the VM and uses the AWS credentials that are already there, so no keys are stored in GitHub.
Self-hosted runners on a public repo can be risky, so the workflow only runs on push to main, never on pull requests, and every deployment needs approval.

## Terraform state
The runner cleans the workspace on every run, which would delete a normal state file. So I used a local backend that keeps the state at ~/tfstate/p18.tfstate on the VM, outside the repo.

## How I tested it
1. Wrote the code on the branch feature/p18-gitops and opened PR #13
2. Merged the PR into main
3. The P18 GitOps Apply workflow started by itself and waited for review
4. Approved the production deployment
5. The apply ran on the VM and the run finished with success
6. A later push to Project-18 started a second run, which also waited for approval before running

## Screenshots
The screenshots are in this folder:
- the production environment settings with me as required reviewer
- the P18 GitOps Apply run that was triggered by merging PR #13 and finished with success after approval
