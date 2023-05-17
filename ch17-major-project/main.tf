########### Create VPC #########

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}

########## Create Internet Gateway ########

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
  }
}

######### Create Private Subnet ########3

resource "aws_subnet" "prv_subnet" {
  cidr_block = "${split("_", var.subnets_cidr[0])[1]}"
  vpc_id = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.azs.names[0]
  tags = {
    Name = "${split("_", var.subnets_cidr[0])[0]}"
  }
}

######### Create Public Subnet ########3

resource "aws_subnet" "pub_subnet" {
  cidr_block = "${split("_", var.subnets_cidr[1])[1]}"
  vpc_id = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.azs.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${split("_", var.subnets_cidr[1])[0]}"
  }
}

 ################ Create EIP ################

 resource "aws_eip" "eip1" {
   vpc = true
 }

 resource "aws_nat_gateway" "ngtw" {
   allocation_id = aws_eip.eip1.id
   subnet_id = aws_subnet.pub_subnet.id
   depends_on = [ aws_eip.eip1 ]
 }


resource "aws_route_table" "prv-rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngtw.id
  }
  tags = {
    Name = "prv-rt-1"
  }
  depends_on = [ aws_nat_gateway.ngtw ]

}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "pub-rt-1"
  }

  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.prv-rt.id
}

resource "aws_route_table_association" "rt_assoc_pub" {
  subnet_id = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub-rt.id
}

