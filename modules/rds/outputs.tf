output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.this.port
}

output "rds_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.this.id
}

output "rds_subnet_group_name" {
  description = "Name of the RDS subnet group"
  value       = aws_db_subnet_group.this.name
}
