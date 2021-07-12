variable "owner_vpc_id" {
  description = "$(owner_vpc_description)"
  default     = "$(owner_vpc_id)"
}
variable "accepter_vpc_id" {
  description = "$(accepter_vpc_description)"
  default     = "$(accepter_vpc_id)"
}
variable "region" {
  default = "us-east-2"
}