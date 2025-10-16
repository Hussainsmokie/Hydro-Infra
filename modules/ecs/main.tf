variable "vpc_id" {}
variable "private_subnets" {}
variable "ecs_sg_id" {}
variable "target_group_arn" {}
variable "listener_arn" {}

resource "aws_ecs_cluster" "hydroscope_cluster" {
  name = "hydroscope-cluster"
}

resource "aws_ecs_task_definition" "hydroscope_task" {
  family                   = "hydroscope-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "hydroscope_service" {
  name            = "hydroscope-service"
  cluster         = aws_ecs_cluster.hydroscope_cluster.id
  task_definition = aws_ecs_task_definition.hydroscope_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [var.listener_arn]
}
