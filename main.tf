provider "aws" {
  region = var.region
}
module "vpc" {
  source                = "./modules/vpc"
  cidr_block            = var.cidr_block
  vpc_name              = var.vpc_name
  num_of_private_subnet = var.num_of_private_subnet
  num_of_public_subnet  = var.num_of_public_subnet
  region                = var.region
  ms                    = var.ms
  node_grp_name         = var.node_grp_name
  ds                    = var.ds
  mis                   = var.mis
}