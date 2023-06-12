output "message" {
  value = "Creating the VPC in Region : ${var.region}"
}

output "instance_details" {
  value = "Instance Detail : ${aws_instance.ubuntuec2.id} "
}


