resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "gitops" {
  bucket        = "raunak-p18-gitops-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Project = "P18"
    Managed = "gitops"
  }
}
