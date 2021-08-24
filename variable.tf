#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-2"
}
variable "owner_vpc_id" {
  description = "$(owner_vpc_description)"
  default     = "$(owner_vpc_id)"
}
variable "accepter_vpc_id" {
  description = "$(accepter_vpc_description)"
  default     = "$(accepter_vpc_id)"
}
#Define IAM User Access Key
variable "access_key" {
  description = "The access_key that belongs to the IAM user"
  type        = string
  sensitive   = true
}
#Define IAM User Secret Key
variable "secret_key" {
  description = "The secret_key that belongs to the IAM user"
  type        = string
  sensitive   = true
}