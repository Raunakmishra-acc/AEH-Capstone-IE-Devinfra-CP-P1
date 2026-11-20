output "instance_id" {
  value = aws_instance.dc.id
}

output "ami_name" {
  value = data.aws_ami.windows.name
}
