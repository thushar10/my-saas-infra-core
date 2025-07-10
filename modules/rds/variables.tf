variable "db_name" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}

variable "project_name" {
  type = string
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to connect to RDS"
  default     = ["10.0.11.0/24", "10.0.12.0/24"] # your EKS private subnets
}