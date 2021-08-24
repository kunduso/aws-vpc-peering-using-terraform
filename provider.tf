terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  alias      = "owner"
  assume_role {
    role_arn = "arn:aws:iam::$(owner_account_id):role/$(assume_role_name)"
  }
}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  alias      = "accepter"
  assume_role {
    role_arn = "arn:aws:iam::$(accepter_account_id):role/$(assume_role_name)"
  }
}