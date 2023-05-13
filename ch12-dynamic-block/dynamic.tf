resource "aws_security_group" "sg1" {
  name        = "allowTraffic"
  description = "Allow traffic from ssh,http,https"

  dynamic "ingress" {

    for_each = var.ports
    iterator = port
    content {

      description = "Allow ${split("_", "${port.value}")[0]} traffic"
      from_port   = split("_", "${port.value}")[1]
      to_port     = split("_", "${port.value}")[1]
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"

    }

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
