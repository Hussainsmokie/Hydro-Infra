variable "vpc_id" {}

# App Server SG
resource "aws_security_group" "appserver-sg" {
  name   = "appserver-sg"
  vpc_id = var.vpc_id

  tags = {
    Name    = "appserver-sg"
    Project = "hydroscope"
  }
}

resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.appserver-sg.id
}

# Bastion SG
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "bastion-sg"
    Project = "hydroscope"
  }
}

# Load Balancer SG
resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "lb-sg"
    Project = "hydroscope"
  }
}

# ECS SG
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow traffic from Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ecs-sg"
    Project = "hydroscope"
  }
}
resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Allow PostgreSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL inbound"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # or adjust to your private CIDR range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "postgres-sg"
    Project = "hydroscope"
  }
}
