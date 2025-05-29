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


########## Inputs for EC2 instance #################

# subnet-064723982ef3cb4e1
# vpc-029215a1ee40d9dc9
# ami-062f0cc54dbfd8ef1
# sg-0455b446125695436
# t2.micro


###### Declaring Variables ########

###### AWS EC2 Instance ####

resource "aws_instance" "app-server" {
  ami                    = "ami-062f0cc54dbfd8ef1"
  subnet_id              = "subnet-064723982ef3cb4e1"
  vpc_security_group_ids = ["sg-0455b446125695436"]
  instance_type          = "t2.micro"
  tags                   = {
    name = "PROD-SERVER"
  }
}

output "public_ip" {
  value = aws_instance.app-server.public_ip
}