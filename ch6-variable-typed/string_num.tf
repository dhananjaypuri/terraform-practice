variable "uname" {
  type = string
  default = "Guest"
}

variable "age" {
  type = number
  default = 20
}

output "user" {
  value = "Hi , My name is ${var.uname}"
}

output "u_age" {
  value = "Hi , My age is ${var.age}"
}

