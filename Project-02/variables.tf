variable "region" {
  default = "us-east-2"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name (must be lowercase)"
  default     = "raunak-capstone-p2"
}
