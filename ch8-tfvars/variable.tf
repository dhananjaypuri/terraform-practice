variable "name" {
  type = string
  default = "Guest"
}

variable "age" {
  type = number
  default = 20
}

output "details" {
  value = "Hi my name is ${var.name} and my age is ${var.age}"
}
