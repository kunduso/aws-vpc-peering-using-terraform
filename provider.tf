terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}
provider "aws" {}
provider "aws" {
  alias = "accepter"
  assume_role {
    role_arn = "arn:aws:iam::$(accepter_account_id):role/$(assume_role_name)"
  }
}