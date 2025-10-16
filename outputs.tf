########################################
# Bastion Outputs (from module)
########################################

output "bastion_id" {
  value = module.bastion.bastion_id
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

########################################
# Optional: RDS Outputs
########################################

output "rds_endpoint" {
  value = module.rds.rds_endpoint
  description = "RDS database endpoint"
}
