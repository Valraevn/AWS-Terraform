terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

// AWS provider
provider "aws" {
  region     = "eu-west-2"
  access_key = "<AWS_ACCESS_KEY>"
  secret_key = "<AWS_SECRET_KEY>"
}

