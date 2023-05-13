variable "users" {
  type = list(string)
}

variable "ages" {
  type = list(number)
}

output "userdata" {
    value = "The name of the first user is ${var.users[0]} and the age is ${var.ages[0]}"
}
