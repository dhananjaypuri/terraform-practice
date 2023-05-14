variable "ami_id" {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "ports" {
  type = list(string)
}

variable "ins_type" {
  type = string
  default = "t2.micro"
}

variable "key" {
  type = string
}

variable "sg" {
  type = string
}
