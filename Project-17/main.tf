data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_cloudwatch_log_group" "apache" {
  name              = "/raunak-p17/apache-access"
  retention_in_days = 1
}
resource "aws_iam_role" "cw_role" {
  name = "raunak-p17-cw-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw_agent" {
  role       = aws_iam_role.cw_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "cw_profile" {
  name = "raunak-p17-cw-profile"
  role = aws_iam_role.cw_role.name
}
resource "aws_security_group" "web_sg" {
  name   = "raunak-p17-web-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.cw_profile.name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y httpd amazon-cloudwatch-agent
    echo "<h1>Project 17 - Logs to CloudWatch</h1>" > /var/www/html/index.html
    systemctl enable --now httpd

    cat > /opt/aws/amazon-cloudwatch-agent/etc/config.json <<CFG
    {
      "agent": { "run_as_user": "root" },
      "logs": {
        "logs_collected": {
          "files": {
            "collect_list": [
              {
                "file_path": "/var/log/httpd/access_log",
                "log_group_name": "${aws_cloudwatch_log_group.apache.name}",
                "log_stream_name": "{instance_id}"
              }
            ]
          }
        }
      }
    }
    CFG

    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json

    for i in $(seq 1 60); do curl -s http://localhost/ > /dev/null; sleep 5; done
  EOF

  tags = {
    Name = "raunak-p17-web"
  }
}
