output "vpc_id" {
  description = "VPC ID created by the VPC module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "private_subnet_cidrs" {
  description = "Private Subnet CIDR blocks"
  value       = var.private_subnet_cidrs
}