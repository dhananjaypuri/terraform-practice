variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "ports" {
  type = list(string)
}

variable "ami" {
  type = string
  default = "ami-007855ac798b5175e"
}

variable "ins_type" {
  type = string
  default = "t2.micro"
}
