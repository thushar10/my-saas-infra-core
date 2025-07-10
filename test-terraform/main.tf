provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "baas-terraform-test-thushar"
  force_destroy = true
}
