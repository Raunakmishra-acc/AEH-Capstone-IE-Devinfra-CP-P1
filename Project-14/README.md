# Project 14 - App Deployment using EKS

## Goal
Provision an EKS cluster with Terraform and deploy an app on it that can be accessed publicly.

## Files
- providers.tf - AWS provider
- variables.tf - region and cluster name
- main.tf - IAM roles, EKS cluster and node group in the default VPC
- outputs.tf - cluster name and endpoint
- app.yaml - Kubernetes Deployment (2 replicas) and LoadBalancer Service

## Steps
1. terraform init, plan and apply - created cluster raunak-p14-eks with one t3.medium node in ap-south-1
2. aws eks update-kubeconfig to connect kubectl to the cluster
3. kubectl get nodes - node was Ready
4. kubectl apply -f app.yaml - deployed my P13 image from ECR (raunak-p13-app:v1)
5. kubectl get pods - both pods Running
6. kubectl get svc - got the public load balancer address
7. Opened the load balancer URL in the browser on my laptop

## Notes
- Used the default VPC since the shared lab account has hit its VPC limit
- Node role has the ECR read only policy so the nodes can pull the image
- Service maps port 80 on the load balancer to port 8080 in the container
- The container ID on the page is the pod name, it changes between the two pods on refresh
- After testing I deleted the service first and then ran terraform destroy
