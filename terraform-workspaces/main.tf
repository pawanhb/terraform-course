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

## ami-00dfdb609405db72c

resource "aws_instance" "tf-instance" {
  //count                  = terraform.workspace == "prod" ? 2 : 1
  ami                    = "ami-062f0cc54dbfd8ef1"
  subnet_id              = "subnet-064723982ef3cb4e1"
  vpc_security_group_ids = ["sg-0455b446125695436"]
  instance_type          = "t2.micro"

  tags = {
    name = "${terraform.workspace}-webserver"
  }
}


######Terraform Logging####################
##### TF_LOG = TRACE, INFO, DEBUG, WARNING, ERROR
##### TF_LOG_PATH=

/*resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = "my1234-tf-test-bucket-a123456789"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}*/