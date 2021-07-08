resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 4096
  private_key_pem = ${{ secrets.SSH_PRIVATE_KEY }}
}

resource "aws_key_pair" "web_server_key" {
  key_name   = var.key_name
  public_key = tls_private_key.mykey.public_key_openssh
}

# Instance
resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.pub_subnet_1_id
  vpc_security_group_ids = [var.web_server_sg_id]
  availability_zone      = var.availability_zone_1
  key_name               = aws_key_pair.web_server_key.key_name
  tags = {
    Name = "aa-terraform-1"
  }
}