terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_lb" "app-lb" {
  name                       = "app-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["sg-0455b446125695436"]
  subnets                    = ["subnet-00c8edbae49d06681","subnet-064723982ef3cb4e1"]
  enable_deletion_protection = false
  tags = {
    name = "application-lb"
  }
}

resource "aws_lb_target_group" "lb-tg" {
  name     = "loadbalancer-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-029215a1ee40d9dc9"
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg-attachment" {
  target_group_arn = aws_lb_target_group.lb-tg.arn
  target_id        = aws_instance.nginx-webapp-1.id
  port             = 80
}