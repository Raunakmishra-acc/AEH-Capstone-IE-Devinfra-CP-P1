variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "domain_name" {
  default = "capstone.local"
}

variable "netbios_name" {
  default = "CAPSTONE"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "dsrm_password" {
  type      = string
  sensitive = true
}
