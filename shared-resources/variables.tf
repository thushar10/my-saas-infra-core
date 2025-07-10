variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "baas"
}

variable "instance_class" {
  description = "Instance type for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Size of RDS disk in GB"
  type        = number
  default     = 20
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS subnet group"
  type        = list(string)
  default     = ["subnet-abc", "subnet-def"]  # Replace with real ones or wire in from state
}

variable "vpc_id" {
  description = "VPC ID where RDS should be created"
  type        = string
  default     = "vpc-xyz"  # Replace with real one or wire in from state
}

variable "project_name" {
  type    = string
  default = "baas"
}