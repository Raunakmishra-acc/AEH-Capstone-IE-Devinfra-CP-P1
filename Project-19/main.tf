resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "backup" {
  bucket        = "raunak-p19-backup-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Project = "P19"
  }
}
