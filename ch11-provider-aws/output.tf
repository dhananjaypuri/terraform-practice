output "instance_details" {
	value = "ID : ${aws_instance.web1.id}, Key name : ${aws_key_pair.tfkey.key_name}"
}
