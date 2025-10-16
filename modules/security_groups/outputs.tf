output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "lb_sg" {
  value = aws_security_group.lb_sg.id
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg.id
}

output "postgres_sg_id" {
  value = aws_security_group.postgres_sg.id
}