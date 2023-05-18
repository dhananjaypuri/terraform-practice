variable "list" {
  type = list(number)
  default = [ 1,3,4,5 ]
}

variable "maps" {
  type = map(string)
  default = {
    "web1" = "10.0.1.1/24"
    "web2" = "10.0.1.2/24"
  }
}

output "list_output" {
  value = [for i in var.list: i]
}

output "maps_output" {
  value = [for i,k in var.maps: "${i} ==> ${k}"]
}
