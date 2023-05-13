## Creating AWS Key pair

resource "aws_key_pair" "tfkey" {
  key_name = "tf-non-prod"
  public_key = file("${path.module}/non-prod.pub")
}

## Creating Security Group

resource "aws_security_group" "sg1" {
  name = "Allow_ssh_http"
  description = "This will allow incoming traffic on port 22 and 80"
  
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

## Creating EC2 and attaching key to it

resource "aws_instance" "web1" {
  instance_type = "t2.micro"
  ami = "ami-007855ac798b5175e"
  key_name = aws_key_pair.tfkey.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  tags = {
    Name = "first-tf-instance"
  }
}
