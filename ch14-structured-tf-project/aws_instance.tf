resource "aws_instance" "server" {
  instance_type = var.ins_type
  ami = var.ami_id
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  key_name = aws_key_pair.keypair.key_name

  user_data = file("${path.module}/script.sh")
  tags = {
    Name = "tf-ubuntu-srv1"
  }
}
