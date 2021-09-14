data "terraform_remote_state" "owner" {
  backend = "s3"
  config = {
    bucket     = "terraform-remote-bucket-skundu"
    key        = "tf/project-23/terraform.tfstate"
    region     = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  }
}

data "terraform_remote_state" "accepter" {
  backend = "s3"
  config = {
    bucket     = "terraform-remote-bucket-skundu"
    key        = "tf/project-22/terraform.tfstate"
    region     = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  }
}

locals {
  accepter_account_id             = data.terraform_remote_state.accepter.outputs.owner_id
  accepter_vpc_id                 = data.terraform_remote_state.accepter.outputs.vpc_id
  owner_account_id                = data.terraform_remote_state.owner.outputs.owner_id
  owner_vpc_id                    = data.terraform_remote_state.owner.outputs.vpc_id
  owner_account_route_table_id    = data.terraform_remote_state.owner.outputs.route_table_id
  accepter_account_route_table_id = data.terraform_remote_state.accepter.outputs.route_table_id
  owner_public_subnet_cidr = data.terraform_remote_state.owner.outputs.public_subnet_cidr
   accepter_public_subnet_cidr = data.terraform_remote_state. accepter.outputs.public_subnet_cidr
}

output "accepter_account_id" {value = local.accepter_account_id}
output "owner_account_id" {value = local.owner_account_id}
output "accepter_vpc_id" {value = local.accepter_vpc_id}
output "owner_vpc_id" {value = local.owner_vpc_id}
output "owner_account_route_table_id" {value = local.owner_account_route_table_id}
output "accepter_account_route_table_id" {value = local.accepter_account_route_table_id}
#output "owner_account_vpc_cidr_block" {value = local.owner_account_vpc_cidr_block}
#output "accepter_account_vpc_cidr_block" {value = local.accepter_account_vpc_cidr_block}
output "owner_public_subnet_cidr" { value = local.owner_public_subnet_cidr }
output "accepter_public_subnet_cidr" { value = local.accepter_public_subnet_cidr }
resource "aws_vpc_peering_connection" "owner" {
  provider      = aws.owner
  vpc_id        = local.owner_vpc_id
  peer_vpc_id   = data.terraform_remote_state.accepter.outputs.vpc_id
  peer_owner_id = local.accepter_account_id
  peer_region   = var.region
  tags = {
    Name = "peer_to_accepter"
  }
}
resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
  auto_accept               = true
  tags = {
    Name = "peer_to_owner"
  }
}
resource "aws_route" "owner" {
  provider                  = aws.owner
  count                     = length(local.accepter_public_subnet_cidr)
  route_table_id            = local.owner_account_route_table_id
  destination_cidr_block    = tolist(local.accepter_public_subnet_cidr)[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
}
resource "aws_route" "accepter" {
  provider                  = aws.accepter
  count                     = length(local.owner_public_subnet_cidr)
  route_table_id            = local.accepter_account_route_table_id
  destination_cidr_block    = tolist(local.owner_public_subnet_cidr)[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.owner.id
} 