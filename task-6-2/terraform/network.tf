#############################################
# VPC
#############################################
module "thesis-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = var.vpc_name
  cidr = "172.16.0.0/16"

  azs                        = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets             = ["172.16.0.0/24", "172.16.1.0/24"]
  enable_nat_gateway         = false
  manage_default_network_acl = false

  tags = {
    Belong    = var.belong_tag
    CreatedBy = "Terraform"
  }
}

