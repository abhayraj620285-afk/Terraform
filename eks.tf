module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = local.name
  cluster_version = "1.31"
  cluster_endpoint_public_access = true

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_addons = {
        vpc-cni = {
            most-recent = true
        }
        kube-proxy = {
            most-recent = true
        }
        coredns = {
            most-recent = true
        }
  }

  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {

    instance_type = ["t3.medium"]
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    raj-cluster-ng= {
     
      instance_types = ["t3.micro"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
      capacity_type = "SPOT"
    }
  }
    
  tags = {
    Environment = local.name
    Terraform = "true"
  }

}