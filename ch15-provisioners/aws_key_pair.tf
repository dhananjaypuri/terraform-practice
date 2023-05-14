resource "aws_key_pair" "keypair" {

  key_name = var.key
  public_key = file("${path.module}/non-prod.pub")
  
}
