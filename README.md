# terraform-eks-cilium
Deploy EKS and cilium

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 5.0 |
| <a name="requirement_cilium"></a> [cilium](#requirement\_cilium) | >=0.1.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cilium"></a> [cilium](#provider\_cilium) | 0.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | v5.0.0 |

## Resources

| Name | Type |
|------|------|
| [cilium_cilium.this](https://registry.terraform.io/providers/littlejo/cilium/latest/docs/resources/cilium) | resource |
| [terraform_data.kubeconfig](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | List of availability zones to install eks | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cilium"></a> [cilium](#input\_cilium) | Feature of cilium | <pre>object({<br>    version                = optional(string, "1.14.3")<br>    kube-proxy-replacement = optional(bool, false)<br>    ebpf-hostrouting       = optional(bool, false)<br>    hubble                 = optional(bool, false)<br>    hubble-ui              = optional(bool, false)<br>    gateway-api            = optional(bool, false)<br>    preflight-version      = optional(string, null)<br>    upgrade-compatibility  = optional(string, null)<br>  })</pre> | <pre>{<br>  "ebpf-hostrouting": false,<br>  "gateway-api": false,<br>  "hubble": false,<br>  "hubble-ui": false,<br>  "kube-proxy-replacement": false,<br>  "version": "1.15.4"<br>}</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name | `string` | `"terraform-cilium"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | kubernetes cluster version | `string` | `"1.29"` | no |
| <a name="input_install_cilium"></a> [install\_cilium](#input\_install\_cilium) | Do you want to install cilium | `bool` | `true` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | VPC CIDR | `string` | `"10.11.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | `"eks"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_update_kubeconfig"></a> [update\_kubeconfig](#output\_update\_kubeconfig) | Command to launch to use kubectl |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->