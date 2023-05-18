provider "aws" {
  region = "us-east-1"
}

variable "ins_details" {
  type = map(string)
  default = {
    "web1" = "ami-007855ac798b5175e_t2.micro"
    "web2" = "ami-007855ac798b5175e_t2.micro"
  }
}

resource "aws_key_pair" "kp" {
  public_key = "${file("${path.module}/non-prod.pub")}"
  key_name = "non-prod"
  tags = {
    Name = "non-prod"
  }
}

resource "aws_instance" "ec2" {
  for_each = (var.ins_details)
  ami = split("_","${each.value}")[0]
  instance_type = split("_","${each.value}")[1]
  associate_public_ip_address = true
  user_data = "${file("${path.module}/script.sh")}"
  tags = {
    Name = each.value
  }
  key_name = "non-prod"

  provisioner "file" {
    source = "test.txt"
    destination = "/tmp/test.txt"
      connection {
    user = "ubuntu"
    type = "ssh"
    private_key = "${file("${path.module}/non-prod.pem")}"
    host = self.public_ip
  }
  }
  depends_on = [ aws_key_pair.kp ]
}

output "ec2_det" {
  value = [for ins in aws_instance.ec2: ins.id]
}

