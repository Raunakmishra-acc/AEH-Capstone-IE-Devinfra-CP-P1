resource "aws_iam_user" "s3_reader" {
  name = var.user_name
  tags = { Project = "Capstone-P4" }
}

resource "aws_iam_policy" "s3_read" {
  name   = "${var.user_name}-policy"
  policy = var.s3_read_policy
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.s3_reader.name
  policy_arn = aws_iam_policy.s3_read.arn
}
