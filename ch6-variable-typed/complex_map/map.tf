variable "userage" {
  type = map
  default = {
    a = 10
    b = 20
  }
}

variable "user" {
  type = string
}

output "uage" {
  value = "My name is ${var.user} and my age is ${lookup(var.userage, var.user, 30)}"
}
