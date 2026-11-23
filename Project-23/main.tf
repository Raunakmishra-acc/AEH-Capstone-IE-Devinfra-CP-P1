resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "data" {
  bucket        = "raunak-p23-data-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_s3_object" "test" {
  bucket  = aws_s3_bucket.data.id
  key     = "hello.txt"
  content = "hello from p23"
}
resource "aws_iam_role" "ec2_s3" {
  name = "raunak-p23-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "s3_read" {
  name = "raunak-p23-s3-read"
  role = aws_iam_role.ec2_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = aws_s3_bucket.data.arn
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.data.arn}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_s3" {
  name = "raunak-p23-profile"
  role = aws_iam_role.ec2_s3.name
}
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "app" {
  ami                  = data.aws_ami.al2023.id
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_s3.name

  user_data = <<-EOF
    #!/bin/bash
    sleep 60
    {
    echo "===== P23 TEST 1: credentials type ====="
    aws configure list
    echo "===== P23 TEST 2: who am i ====="
    aws sts get-caller-identity
    echo "===== P23 TEST 3: list bucket ====="
    aws s3 ls s3://${aws_s3_bucket.data.bucket}/ --region ap-south-1
    echo "===== P23 TEST 4: read file ====="
    aws s3 cp s3://${aws_s3_bucket.data.bucket}/hello.txt - --region ap-south-1
    echo
    echo "===== P23 TEST 5: upload should be denied ====="
    echo test > /tmp/t.txt
    aws s3 cp /tmp/t.txt s3://${aws_s3_bucket.data.bucket}/t.txt --region ap-south-1
    echo "===== P23 TESTS DONE ====="
    } 2>&1 | tee /dev/ttyS0
  EOF

  tags = {
    Name = "raunak-p23-app"
  }
}
