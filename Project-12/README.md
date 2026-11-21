# Project 12 - Infrastructure CI Trigger (Terraform Plan)

## What the task asked
Run terraform plan automatically whenever code is pushed, and save the plan as an artifact so it can be checked later.

## What I did
Since main is protected from Project 11, I made a feature branch called feature/p12-plan and did the work there.

In the Project-12 folder I wrote a small Terraform file with one S3 bucket. Before pushing I ran terraform init, fmt and validate on the server to make sure the config was fine.

Then I added a GitHub Actions workflow called p12-plan.yml. It runs on every push that touches the Project-12 folder or the workflow file itself. The job checks out the code, installs Terraform, runs init and validate, and then runs terraform plan and saves the output to a file. I also convert the plan into plain text with terraform show so anyone can open it and read it. Both files get uploaded as an artifact named tfplan.

When I pushed the branch, the workflow started on its own and finished successfully in around 20 seconds, and the tfplan artifact was there in the run. After that I opened a pull request and merged it into main.

## About AWS credentials
I didn't put any real AWS keys in GitHub. The provider uses dummy keys and skips the AWS account checks, which is enough for Terraform to plan a new resource without talking to AWS. The idea was to keep secrets out of the repo. In a real setup I would use OIDC or GitHub secrets so the plan can also compare against what already exists in the account.

## What I learned
How to trigger a pipeline on push using path filters, how terraform plan can be saved and shared as an artifact, and why it is better to keep cloud credentials out of CI where possible.
