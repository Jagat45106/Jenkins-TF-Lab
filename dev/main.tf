terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34.0"
    }
  }

  backend "s3" {
    bucket         	   = "jagat-remote-backend-lab"
    key              	   = "terraformstate/terraform.tfstate"
    region         	   = "us-west-2"
    encrypt        	   = true
    dynamodb_table = "jagat-terraform-be"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "dev-my-tf-test-bucket-jagat"

  tags = {
    Name        = "dev-my-tf-test-bucket-jagat"
    Environment = "dev"
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}