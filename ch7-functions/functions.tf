variable "users" {
  type = list
  default = ["gaurav", "Abhi", "akul"]
}

variable "words" {
  type = list(string)
  default = ["a", "b", "c"]
}

variable "nums" {
  type = list(number)
  default = [1, 2, 3]
}

output "toupper" {
  value = "Upper value is : ${upper(var.users[0])}"
}

output "tolower" {
  value = "Lower value is : ${lower(var.users[1])}"
}

output "totitle" {
  value = "Lower value is : ${title(var.users[1])}"
}

output "join" {
  value = join("==>", var.users)
}

output "zipmap" {
  value = zipmap(var.words, var.nums)
}
