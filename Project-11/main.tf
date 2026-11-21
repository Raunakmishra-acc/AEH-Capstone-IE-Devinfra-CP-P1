terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "logs" {
  bucket = "raunak-p11-logs"

  tags = {
    Project = "P11"
    Env     = "dev"
  }
}
