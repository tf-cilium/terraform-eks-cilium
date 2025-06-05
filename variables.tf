variable "azs" {
  description = "List of availability zones to install eks"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "eks"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "terraform-cilium"
}

variable "cluster_version" {
  description = "kubernetes cluster version"
  type        = string
  default     = "1.33"
}

variable "service_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.11.0.0/16"
}

variable "install_cilium" {
  description = "Do you want to install cilium"
  type        = bool
  default     = true
}

variable "cilium" {
  description = "Feature of cilium"
  type = object({
    version                = optional(string, "1.17.4")
    kube-proxy-replacement = optional(bool, false)
    ebpf-hostrouting       = optional(bool, false)
    hubble                 = optional(bool, false)
    hubble-ui              = optional(bool, false)
    gateway-api            = optional(bool, false)
    preflight-version      = optional(string, null)
    upgrade-compatibility  = optional(string, null)
  })
  default = {
    version                = "1.17.4"
    kube-proxy-replacement = false
    ebpf-hostrouting       = false
    hubble                 = false
    hubble-ui              = false
    gateway-api            = false
  }
}
