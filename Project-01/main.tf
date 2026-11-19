resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  # Place the instance in our own VPC/subnet with our security group
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  # Re-create the instance whenever the script changes
  user_data_replace_on_change = true

  user_data = <<-USERDATA
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Welcome to AEH Capstone Project 01</h1>" > /var/www/html/index.html
  USERDATA

  tags = {
    Name    = var.project_name
    Project = "AEH-Capstone"
  }
}
