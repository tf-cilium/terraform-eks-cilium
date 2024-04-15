terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0"
    }
    cilium = {
      source  = "littlejo/cilium"
      version = ">=0.1.10"
    }
  }
  required_version = "> 1.4"
}

provider "aws" {
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "eks"
    }
  }
}

provider "cilium" {
  config_path = terraform_data.kubeconfig.input
}
