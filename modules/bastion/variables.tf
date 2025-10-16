variable "subnet_id" {}
variable "security_group_id" {}
variable "instance_type" {
  type        = string
  default     = "t3.small"
  description = "EC2 instance type for Bastion host"
}
