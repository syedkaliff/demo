provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  

}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 3"
      version = "~>3.75.1"

    }
  }

}