variable "region" {
  type        = string
  description = "AWS Region"
}

variable "vpc_name" {
  type        = string
  description = "name of the vpc"
}
variable "cidr_block" {
  type        = string
  description = "cidr_block_vpc"
  default     = "10.0.0.0/16"
}
variable "availability_zone" {
  type        = list(string)
  description = "list of availability_for_private"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}
variable "ds" {
  type = number
}
variable "ms" {
  type = number
}
variable "mis" {
  type = number
}
variable "num_of_private_subnet" {
  type        = number
  description = "no. of private subnet"
}
variable "num_of_public_subnet" {
  type        = number
  description = "no. of public subnet"
}
variable "node_grp_name" {
  type        = string
  description = "name of the node group"
}