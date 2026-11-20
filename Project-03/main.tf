data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "p3" {
  name_prefix = "p3-sg-"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_key_pair" "p3" {
  key_name_prefix = "p3-key-"
  public_key      = file(pathexpand("~/.ssh/p3_key.pub"))
}

resource "aws_instance" "p3" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.p3.id]
  key_name                    = aws_key_pair.p3.key_name
  associate_public_ip_address = true
  monitoring                  = true
  user_data_replace_on_change = true

  user_data = <<-SCRIPT
    #!/bin/bash
    apt-get update -y
    apt-get install -y stress-ng
    sleep 60
    stress-ng --cpu 0 --timeout 900
  SCRIPT

  tags = { Name = "p3-cpu-monitor-ec2" }
}

resource "aws_sns_topic" "p3" {
  name_prefix = "p3-cpu-alerts-"
}

resource "aws_sns_topic_subscription" "p3" {
  topic_arn = aws_sns_topic.p3.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "p3-high-cpu-${aws_instance.p3.id}"
  alarm_description   = "CPU above ${var.cpu_threshold}% on P3 instance"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 2
  threshold           = var.cpu_threshold
  comparison_operator = "GreaterThanThreshold"
  dimensions          = { InstanceId = aws_instance.p3.id }
  alarm_actions       = [aws_sns_topic.p3.arn]
  ok_actions          = [aws_sns_topic.p3.arn]
}
