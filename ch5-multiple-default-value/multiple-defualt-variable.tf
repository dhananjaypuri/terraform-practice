variable "uname" {
  default = "Dhananjay Puri"
}

variable "age" {
  
}

output "user" {
  value = "My name is ${var.uname}"
}

output "uname" {
  value = "My age is ${var.age}"
}

## You can use the command to set your value terraform plan -var "uname=Anuj Puri" -var
## "age=23" Note : If defaut value is set and value is not passed by command then it will take default values
