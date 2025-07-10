output "rds_endpoint" {
  description = "Endpoint address of the RDS database"
  value       = module.rds.rds_endpoint
}
