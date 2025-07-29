provider "aws" {
  region = "ap-south-1"
}

module "rds" {
  source              = "../modules/rds"
  db_name             = var.db_name
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  # Use the outputs from the destroyable_stack
  subnet_ids          = data.terraform_remote_state.destroyable_stack.outputs.private_subnet_ids
  vpc_id              = data.terraform_remote_state.destroyable_stack.outputs.vpc_id
  project_name        = var.project_name
  # This allows the RDS security group to accept traffic from the EKS private subnets
  allowed_cidr_blocks = data.terraform_remote_state.destroyable_stack.outputs.private_subnet_cidrs
}

data "terraform_remote_state" "destroyable_stack" {
  backend = "s3"
  config = {
    bucket = "my-saas-tf-state"
    key    = "destroyable-stack/terraform.tfstate"
    region = "ap-south-1"
  }
}