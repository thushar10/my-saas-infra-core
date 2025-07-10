variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "node_group_name" {}
variable "instance_type" {}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
