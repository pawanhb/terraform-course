### Initialization ###

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

data "aws_availability_zones" "available" {
  state = "available"
}

###################################
##### Resources
###################################


######
## VPC
## Internet Gateway
## Route Table
## Routes
## Routing Associations
## Subnets
## Security Groups
## Instance
######


# NETWORKING

resource "aws_vpc" "app" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.app.id
}

resource "aws_subnet" "public_subnet1" {
  cidr_block              = var.subnet1_cidr
  vpc_id                  = aws_vpc.app.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
  cidr_block              = var.subnet2_cidr
  vpc_id                  = aws_vpc.app.id
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
}


#ROUTINGS

resource "aws_route_table" "app-route-table" {
  vpc_id = aws_vpc.app.id
  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.app-igw.id
  }
}

resource "aws_route_table_association" "app-subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.app-route-table.id
}

resource "aws_route_table_association" "app-subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.app-route-table.id
}


## Security Group

resource "aws_security_group" "nginx-sg" {
  name   = "nginx-sg"
  vpc_id = aws_vpc.app.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr]
  }
}


resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.app.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.internet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr]
  }
}


output "instance-op" {
  value = "http://${aws_lb.app-lb.dns_name}"
}