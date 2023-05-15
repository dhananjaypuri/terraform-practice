terraform {
  backend "s3" {
    bucket = "statefile-s3-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "web1" {
  instance_type = var.ins_type
  ami = var.ami
  key_name = var.key
}
