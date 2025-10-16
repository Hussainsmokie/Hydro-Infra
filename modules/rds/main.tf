########################################
# RDS Subnet Group
########################################
resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name    = "${var.project}-rds-subnet-group"
    Project = var.project
  }
}

########################################
# RDS PostgreSQL Instance
########################################
resource "aws_db_instance" "this" {
  identifier              = "${var.project}-rds"
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = var.publicly_accessible
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  multi_az                = var.multi_az
  storage_type            = "gp3"
  auto_minor_version_upgrade = false

  tags = {
    Name    = "${var.project}-rds"
    Project = var.project
  }
}
