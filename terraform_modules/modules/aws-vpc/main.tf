# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr #You can change the CIDR block as per required
  enable_dns_hostnames = true

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main_vpc_igw"
  }
}

# Public subnet
resource "aws_subnet" "pub_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_cidr_1
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub_subnet_1"
  }
}

# Route table
resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub_rtb"
  }
}

resource "aws_route_table_association" "pub_rtb_assoc_1" {
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.pub_rtb.id
}


resource "aws_network_acl" "pub_nacl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.pub_subnet_1.id]

  #HTTP Port
  ingress {
    rule_no    = 640
    action     = "allow"
    protocol   = all
    cidr_block = "0.0.0.0/0"
  }

  #HTTP Port
  egress {
    rule_no    = 630
    action     = "allow"
    protocol   = all
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "pub_nacl"
  }
}