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

module "ec2-module" {
  source             = "./modules/ec2-module"
  instancetype       = "t2.micro"
  ami_id             = "ami-0af9569868786b23a"
  security_group_ids = ["sg-0455b446125695436"]
  subnetid           = "subnet-064723982ef3cb4e1"
}

output "op" {
  value = module.ec2-module.instance_details
}
