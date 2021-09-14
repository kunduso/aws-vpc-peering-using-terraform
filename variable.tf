#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-2"
}
variable "owner_vpc_id" {
  description = "vpc id of the peering owner"
  default     = ""
}
variable "accepter_vpc_id" {
  description = "vpc id of the peering accepter"
  default     = ""
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