#resource "tls_private_key" "mykey" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#  private_key_pem =
#}

resource "aws_key_pair" "web_server_key" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkEj1MjhLb2CxaLu1aooMpecUzdu5uS4i9XkUQnm7PX9xERdRda036puUhN5Ck3X0iCLZbpdAfl0GiR4mmzJz7utkV0bGD/U778HzQhAJiT11zMtcrR3GgJrhUJjmz9lKpBb/fdG4asvWbOB64i8dL4V99xis9PMhkzOg4pWSECbj0xwF4UR5KHqbZXVH64baOpQg1riv/xRO1Sbds/NMV3lumvr2mCdyHc1P22l28g2Yaqmn0Cb4CU1EVgYqkr93wGoIxs853crVVBp1N/BmgJbWWeqTjKwW7fbqlIMC3S1yMEjbPpJgOdTSKmSQJ5nRQ+a7MEqnEqbyc2B/vL9lRnLi8EjLPn13+mHeg1bu5JxG6jKl1Xf6iVRtQ7U1a15NBGxrt1VzstVX4Okg3XhoXnAOTxzrqYRDBbfG6ac0ZZD3JAa8MPmizfjrj3jVhHsgO6rvso5DXOBSKpngkiNrulmab6PBfNjbObhHNbwlNSefwCe+p96Dkg7rqrVjQSuk= aws_terraform"
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