variable "project" {
  description = "Project name for tagging and resource naming"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for RDS"
  type        = list(string)
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
  default     = 25
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16.10"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.small"
}

variable "db_username" {
  description = "Master DB username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether RDS should be publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether to skip snapshot on deletion"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Whether to deploy Multi-AZ RDS"
  type        = bool
  default     = false
}
