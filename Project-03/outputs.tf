output "instance_id" {
  value = aws_instance.p3.id
}

output "public_ip" {
  value = aws_instance.p3.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/p3_key ubuntu@${aws_instance.p3.public_ip}"
}

output "alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}
