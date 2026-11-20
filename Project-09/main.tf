data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

resource "aws_iam_role" "ssm_role" {
  name = "p9-dc-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "p9-dc-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_security_group" "dc_sg" {
  name        = "raunak-p9-dc-ssm-role"
  description = "dc sg - access through ssm"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dc" {
  ami                    = data.aws_ami.windows.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  vpc_security_group_ids = [aws_security_group.dc_sg.id]

  user_data = <<-EOF
    <powershell>
    net user Administrator "${var.admin_password}"
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
    $safe = ConvertTo-SecureString "${var.dsrm_password}" -AsPlainText -Force
    Install-ADDSForest -DomainName "${var.domain_name}" -DomainNetbiosName "${var.netbios_name}" -SafeModeAdministratorPassword $safe -InstallDns -Force
    </powershell>
  EOF

  tags = {
    Name = "p9-domain-controller"
  }
}
