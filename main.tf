# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Create EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "simple-eks-cluster"
  cluster_version = "1.30"
  vpc_id          = var.aws_vpc
  subnet_ids         = [var.vpc_subnet_1, var.vpc_subnet_2]

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t3.micro"
    }
  }
}