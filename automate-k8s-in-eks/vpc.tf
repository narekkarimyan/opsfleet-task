module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name                 = "eks-vpc"
  cidr                 = "172.32.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["172.32.1.0/24", "172.32.2.0/24", "172.32.3.0/24"]
  public_subnets       = ["172.32.5.0/24", "172.32.6.0/24", "172.32.7.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
