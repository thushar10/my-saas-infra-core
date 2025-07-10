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