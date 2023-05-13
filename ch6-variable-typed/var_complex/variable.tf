variable "users" {
  type = list(string)
}

variable "ages" {
  type = list(number)
}

variable "ismarried" {
  type = bool
default = false
}
