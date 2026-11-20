output "user_arn" { value = aws_iam_user.s3_reader.arn }
output "policy_arn" { value = aws_iam_policy.s3_read.arn }
