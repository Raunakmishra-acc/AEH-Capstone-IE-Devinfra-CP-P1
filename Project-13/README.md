# Project 13 - Build Image and Push to ECR

## Goal
Build a Docker image for a small Python app and push it to a private Amazon ECR repository.

## Files
- Dockerfile - uses python:3.12-slim and runs app.py
- app.py - simple Python web app
- push.sh - ECR login, build, tag and push commands

## Steps
1. Logged in to ECR with aws ecr get-login-password and docker login
2. Built the image: docker build -t p13-app .
3. Tagged it with the ECR repo URI as v1
4. Pushed it: docker push <account>.dkr.ecr.ap-south-1.amazonaws.com/raunak-p13-app:v1

## Result
- Repository: raunak-p13-app (ap-south-1)
- Image tag: v1, status ACTIVE

## Note
My console login in the lab account does not have ECR read permission,
so the proof below is taken from the AWS CLI on the VM.

## Screenshot
