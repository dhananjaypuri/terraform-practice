resource "aws_key_pair" "non-prod-key" {
  key_name = "non-prod-key"
  public_key = file("${path.module}/non-prod.pub")
}

resource "aws_vpc" "demovpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_internet_gateway" "myigw" {
  depends_on = [ aws_vpc.demovpc ]
  vpc_id = aws_vpc.demovpc.id
  tags = {
    Name = "myigw"
  }
}

resource "aws_subnet" "aws_sub" {
  depends_on = [ aws_vpc.demovpc ]
  vpc_id = aws_vpc.demovpc.id
  count = length(var.subnets)
  availability_zone = "${split(":",element(var.subnets, count.index))[0]}"
  cidr_block = "${split(":",element(var.subnets, count.index))[2]}"
  tags = {
    Name = "${split(":",element(var.subnets, count.index))[1]}"
  }
}

resource "aws_eip" "eip1" {
  vpc = true
}

resource "aws_nat_gateway" "natgtw" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.aws_sub[1].id
  depends_on = [ aws_eip.eip1 , aws_vpc.demovpc ]
}

resource "aws_route_table" "prv-rt" {
  depends_on = [ aws_nat_gateway.natgtw , aws_vpc.demovpc]
  vpc_id = aws_vpc.demovpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgtw.id
  }

  tags = {
    Name = "Prv-rt"
  }

}

resource "aws_route_table" "pub-rt" {
  depends_on = [ aws_internet_gateway.myigw ]
  vpc_id = aws_vpc.demovpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "Pub-rt"
  }


}

resource "aws_route_table_association" "prv_assoc" {
  route_table_id = aws_route_table.prv-rt.id
  subnet_id = aws_subnet.aws_sub[0].id
  depends_on = [ aws_route_table.prv-rt, aws_subnet.aws_sub[0] ]
}

resource "aws_route_table_association" "pub_assoc" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id = aws_subnet.aws_sub[1].id
  depends_on = [ aws_route_table.pub-rt , aws_subnet.aws_sub[1] ]
}

resource "aws_security_group" "non-prod-sg" {
  depends_on = [ aws_vpc.demovpc ]
  vpc_id = aws_vpc.demovpc.id
  dynamic "ingress" {
    for_each = toset(var.ports)
    iterator = port
    content {
      description = "Allow ${split("_", port.value)[0]} from port ${split("_", port.value)[1]}"
      to_port = split("_", port.value)[1]
      from_port = split("_", port.value)[1]
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "tcp"
    }
  }
  egress {
    to_port = 0
    from_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "ubuntuec2" {
  ami = var.ami
  subnet_id = aws_subnet.aws_sub[1].id
  key_name = aws_key_pair.non-prod-key.key_name
  vpc_security_group_ids = [aws_security_group.non-prod-sg.id]
  instance_type = var.ins_type
  associate_public_ip_address = true
  tags = {
    Name = "Non-prod-ec2"
  }
}
