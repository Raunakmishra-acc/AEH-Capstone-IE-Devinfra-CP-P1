variable "user_name" {
  type    = string
  default = "raunak-p4-s3-reader"
}

variable "s3_read_policy" {
  description = "S3 read-only policy JSON"
  type        = string
  default     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:ListBucket", "s3:ListAllMyBuckets"],
    "Resource": "*"
  }]
}
POLICY
}
