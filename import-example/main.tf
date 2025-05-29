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

#### Import external resources

/*import {
  to = aws_instance.migrated-to-tf
  id = "i-0dd7726e1dbfb049e"
}

resource "aws_instance" "migrated-to-tf" {
  ami           = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
}*/

resource "aws_instance" "web-servers" {
  count                  = 2
  ami                    = "ami-0af9569868786b23a"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-064723982ef3cb4e1"
  vpc_security_group_ids = ["sg-0455b446125695436"]
  tags = {
    name = "webserver-${count.index}"
  }
}

output "instances_created" {
  value = aws_instance.web-servers[*].id
}

