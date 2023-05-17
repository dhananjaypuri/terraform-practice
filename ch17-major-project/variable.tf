variable "region" {
  type = string
  default = "us-east-1"
}

variable "cidr" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
  default = true

}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "vpc_name" {
  type = string
}

variable "subnets_cidr" {
  type = list(string)
}
