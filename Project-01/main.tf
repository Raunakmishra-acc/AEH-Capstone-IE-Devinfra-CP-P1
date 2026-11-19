resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2 
    systemctl start apache2
    echo "<h1>Welcome to AEH Capstone Project 01</h1>" > /var/www/html/index.html
    EOF



  tags = {
    Name    = var.project_name
    Project = "AEH-Capstone"
  }

}
