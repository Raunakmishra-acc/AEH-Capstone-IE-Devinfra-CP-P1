data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  monitoring    = true

  user_data = <<-EOF
    #!/bin/bash
    sleep 300
    timeout 900 sh -c 'while true; do :; done' &
  EOF

  tags = {
    Name = "raunak-p21-app"
  }
}
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "raunak-p21-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 CPU Utilization"
          region  = "ap-south-1"
          stat    = "Average"
          period  = 60
          metrics = [["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.app.id]]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 Network In / Out"
          region  = "ap-south-1"
          stat    = "Sum"
          period  = 60
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", aws_instance.app.id],
            ["AWS/EC2", "NetworkOut", "InstanceId", aws_instance.app.id]
          ]
        }
      }
    ]
  })
}
