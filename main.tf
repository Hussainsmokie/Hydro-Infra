terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "ap-south-1"
}


module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "bastion" {
  source             = "./modules/bastion"
  subnet_id          = module.vpc.public_subnet_1
  security_group_id  = module.security.bastion_sg
  instance_type      = "t3.small"
}


module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnets
  lb_sg_id            = module.security.lb_sg
}


module "ecs" {
  source              = "./modules/ecs"
  vpc_id              = module.vpc.vpc_id
  private_subnets     = module.vpc.private_subnets
  ecs_sg_id           = module.security.ecs_sg
  target_group_arn    = module.alb.target_group_arn
  listener_arn        = module.alb.listener_arn
}

module "rds" {
  source                 = "./modules/rds"
  subnet_ids             = module.vpc.private_subnets       # ✅ correct output name
  vpc_security_group_ids = [module.security.postgres_sg_id] # ✅ output from security module
  project                = "hydroscope"
  db_password            = "Hydroscope2025!"
}