# Project 11 - Infra Changes with Branching Policy

## What the task asked
Follow a branching strategy for infrastructure changes. Create a feature branch, raise a pull request and merge it after review. The deliverable is PR screenshots.

## Branching policy
I added a branch protection rule on main with "Require a pull request before merging". So nobody can push straight to main, every change has to come from a feature branch through a PR. I kept the approval count at 0 because I am working alone and GitHub doesn't let you approve your own PR. In a real team I would set at least 1 approval from a teammate.

## What I did
On the SRE server I pulled the latest main and created a feature branch called feature/p11-tags.

In Project-11 I wrote a small Terraform change, an S3 bucket for logs with Project and Env tags. I ran terraform init, fmt and validate, and the config was valid. I did not apply it because the task is about the change process, not creating the resource.

I committed main.tf and pushed the branch to GitHub.

Then I opened PR #2 from feature/p11-tags into main. The CI workflow from Project 7 ran on the PR and both checks passed. I reviewed the change in the Files changed tab and left a review comment. After that I merged the PR and deleted the feature branch.

Finally I switched back to main on the server and pulled, so the local copy has the merged change.

## Files in this folder
- main.tf with the logs bucket and tags
- Screenshots of the branch protection rule, the PR opened, the review comment and the merged PR
