terraform {
  backend "s3" {
    bucket         = "skundu-terraform-remote-state"
    encrypt        = true
    key            = "tf/vpc-peering/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock-table"
  }
}