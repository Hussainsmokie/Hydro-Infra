output "bastion_id" {
  value = aws_instance.bastion.id
}

output "bastion_public_ip" {
  value = aws_eip.bastion_eip.public_ip
}

