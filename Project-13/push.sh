ACC=$(aws sts get-caller-identity --query Account --output text)
REPO=$ACC.dkr.ecr.ap-south-1.amazonaws.com/raunak-p13-app

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ACC.dkr.ecr.ap-south-1.amazonaws.com
docker build -t p13-app Project-13
docker tag p13-app:latest $REPO:v1
docker push $REPO:v1
