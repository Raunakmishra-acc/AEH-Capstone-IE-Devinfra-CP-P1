output "log_group" {
  value = aws_cloudwatch_log_group.apache.name
}

output "instance_id" {
  value = aws_instance.web.id
}
