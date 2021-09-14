terraform {
  backend "s3" {
    bucket         = "skundu-terraform-remote-state-two"
    encrypt        = true
    key            = "tf/project-24/terraform.tfstate"
    region         = "us-east-2"
  }
}