variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "baas"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "baas-cluster"
}

variable "node_group_name" {
  description = "Name of EKS node group"
  type        = string
  default     = "default-node-group"
}

variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 1
}
