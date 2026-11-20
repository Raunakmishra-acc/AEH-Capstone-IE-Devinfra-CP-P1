# Project 7: CI Validation for Terraform

![Terraform CI](https://github.com/Raunakmishra-acc/AEH-Capstone-IE-Devinfra-CP-P1/actions/workflows/terraform-ci.yml/badge.svg)

## Goal
Automate IaC checks.

## What it does
GitHub Actions workflow `.github/workflows/terraform-ci.yml` runs on every push and pull request:
1. `terraform fmt -check -recursive`: fails if any .tf file is not formatted
2. `terraform init -backend=false` + `terraform validate` in every folder that has .tf files

## Issue found and fixed
- Run #1 failed: Project-03 uses `file("~/.ssh/p3_key.pub")`, which does not exist on the CI runner
- Fix: CI step generates a dummy SSH key before validation
- Run #2 passed

## Note
Pushing workflow files requires the token to have the `workflow` scope.
