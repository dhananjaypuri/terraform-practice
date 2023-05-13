variable "userage" {
  type = map
  default = {
    a = 10
    b = 20
  }
}

output "uage" {
  value = "The age of A is : ${lookup(var.userage, "a")} and value of B is : ${lookup(var.userage, "b")}"
}
