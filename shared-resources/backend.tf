terraform {
  backend "s3" {
    bucket         = "my-saas-tf-state"            # Same as the bucket you created
    key            = "shared-resources/terraform.tfstate"  # Unique per stack
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"             # Locking table you created
    encrypt        = true
  }
}