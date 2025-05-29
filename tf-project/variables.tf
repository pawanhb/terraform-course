variable "aws_vpc_cidr" {
  type        = string
  description = "cidr block for VPC"
}

variable "subnet1_cidr" {
  type        = string
  description = "cidr block for subnet 1"
}

variable "subnet2_cidr" {
  type        = string
  description = "cidr block for subnet 1"
}

variable "internet_cidr" {
  type        = string
  description = "cidr block for internet traffic"
}