resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "tf_tracked" {
  bucket = "raunak-capstone-p6-${random_id.suffix.hex}"
  tags = {
    Project = "Capstone-P6"
    Version = "v1"
  }
}

