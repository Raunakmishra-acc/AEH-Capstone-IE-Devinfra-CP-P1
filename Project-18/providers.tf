terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "local" {
    path = "/home/clouduser/tfstate/p18.tfstate"
  }
}

provider "aws" {
  region = "ap-south-1"
}
