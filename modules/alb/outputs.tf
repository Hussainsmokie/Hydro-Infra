output "target_group_arn" {
  value = aws_lb_target_group.hydroscope_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.hydroscope_listener.arn
}
