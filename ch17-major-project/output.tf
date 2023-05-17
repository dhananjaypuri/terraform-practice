output "available_azs" {
  value = data.aws_availability_zones.azs.names
}
