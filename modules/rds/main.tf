resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "baas-db-password"
}

resource "aws_db_instance" "baas_rds" {
  identifier         = "${var.project_name}-rds"
  allocated_storage  = var.allocated_storage
  engine             = "postgres"
  instance_class     = var.instance_class
  name               = var.db_name
  username           = "admin"
  password           = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = []  # Optional: security groups
  skip_final_snapshot = true
  publicly_accessible = false
}
