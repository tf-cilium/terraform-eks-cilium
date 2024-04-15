locals {
  subnets_num       = length(var.azs)
  total_subnets_num = local.subnets_num * 2
  num_list          = [for i in range(0, local.total_subnets_num) : local.subnets_num]
  subnets_cidr      = cidrsubnets(var.cidr, local.num_list...)

  taints_cilium = {
    cilium = {
      key    = "node.cilium.io/agent-not-ready"
      value  = "true"
      effect = "NO_EXECUTE"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v5.0.0"

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = slice(local.subnets_cidr, 0, local.subnets_num)
  public_subnets  = slice(local.subnets_cidr, local.subnets_num, local.total_subnets_num)

  enable_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true

  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnets
  control_plane_subnet_ids  = module.vpc.private_subnets
  cluster_service_ipv4_cidr = var.service_cidr

  cluster_encryption_config = {}
  cluster_enabled_log_types = []

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
    taints         = var.install_cilium ? local.taints_cilium : {}
  }

  eks_managed_node_groups = {
    cilium = {
      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }
}

resource "terraform_data" "kubeconfig" {
  input = "./kubeconfig"
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --kubeconfig ./kubeconfig"
  }
  depends_on = [module.eks]
}

resource "cilium" "this" {
  count = var.install_cilium ? 1 : 0
  set = [
    "cluster.name=${var.cluster_name}"
  ]
  version    = var.cilium.version
  depends_on = [terraform_data.kubeconfig]
}
