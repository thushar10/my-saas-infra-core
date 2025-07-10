provider "aws" {
  region = "ap-south-1"
}

module "rds" {
  source             = "../modules/rds"
  db_name            = var.db_name
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
  project_name       = var.project_name
}
