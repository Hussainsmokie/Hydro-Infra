variable "vpc_id" {}
variable "public_subnets" {}
variable "lb_sg_id" {}

resource "aws_lb" "hydroscope_alb" {
  name               = "hydroscope-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnets

  tags = {
    Name    = "hydroscope-alb"
    Project = "hydroscope"
  }
}

resource "aws_lb_target_group" "hydroscope_tg" {
  name        = "hydroscope-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name    = "hydroscope-tg"
    Project = "hydroscope"
  }
}

resource "aws_lb_listener" "hydroscope_listener" {
  load_balancer_arn = aws_lb.hydroscope_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hydroscope_tg.arn
  }
}
