resource "aws_instance" "server" {
  instance_type = var.ins_type
  ami = var.ami_id
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  key_name = aws_key_pair.keypair.key_name

  user_data = file("${path.module}/script.sh")
  tags = {
    Name = "tf-ubuntu-srv1"
  }
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/non-prod.pem")
      host = self.public_ip
    }
  provisioner "file" {
    source = "test.txt"
    destination = "/tmp/test.txt"

  }

  provisioner "local-exec" {
    working_dir = "/tmp/"
    command = "bash commands_local-exec.sh"
  }

  provisioner "remote-exec" {
    script = "./commands_remote-exec.sh"
  }

}
