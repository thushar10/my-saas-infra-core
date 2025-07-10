resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "baas-db-password"
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow DB access from EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # e.g., EKS private subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "baas_rds" {
  identifier         = "${var.project_name}-rds"
  allocated_storage  = var.allocated_storage
  engine             = "postgres"
  instance_class     = var.instance_class
  #name               = var.db_name
  username           = "admin"
  password           = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true
  publicly_accessible = false

}
