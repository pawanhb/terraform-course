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

resource "aws_iam_user" "developer-1" {
  name = "developer1"
  path = "/developers/"
}

resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

resource "aws_iam_group_membership" "developer-team" {
  name = "tf-developer-group-membership"

  users = [
    aws_iam_user.developer-1.name
  ]

  group = aws_iam_group.developers.name
}