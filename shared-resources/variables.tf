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

variable "project_name" {
  type    = string
  default = "baas"
}