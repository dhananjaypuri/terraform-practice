resource "aws_security_group" "tf_sg" {
  name = var.sg
  description = "Allow traffic for ssh,http,https"
  
  dynamic "ingress" {
    for_each = var.ports
    iterator = port

    content {

    description = "Allow traffic from ${split("_", "${port.value}")[0]}"
    from_port = split("_", "${port.value}")[1]
    to_port = split("_", "${port.value}")[1]
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"

    }
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1
    ipv6_cidr_blocks = ["::/0"]
  }
}
