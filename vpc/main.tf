// terragrunt can deploy modules directly (ie. vpc from the terraform registry)
// but I find it easier to use terragrunt to deploy the service module
// this makes the code more maintainable in the future, as you can also add your peering / vpc endpoints in this module
// also you can keep your subnetting logic internal to the vpc module to prevent repeating yourself

locals {
  // this just works for 10.0* ranges
  subnet_block = substr(var.cidr_block, 0, 5)
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "${var.prefix}-vpc"
  cidr               = var.cidr_block
  azs                = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets    = ["${local.subnet_block}1.0/24", "${local.subnet_block}2.0/24", "${local.subnet_block}3.0/24"]
  public_subnets     = ["${local.subnet_block}101.0/24", "${local.subnet_block}102.0/24", "${local.subnet_block}103.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = var.is_production ? false : true
  enable_vpn_gateway = false
}