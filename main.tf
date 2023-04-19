# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_vpc" "vpc1" {
  cidr_block                       = "10.16.0.0/16"
  assign_generated_ipv6_cidr_block = true
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "a4l-vpc1"
  }
}

# Create 4 Subnets on Availablity Zone A
resource "aws_subnet" "subnet_nameA" {
  vpc_id                          = aws_vpc.vpc1.id
  availability_zone               = var.az[0]
  cidr_block                      = var.cidrA[count.index]
  map_public_ip_on_launch         = count.index == 3 ? true : false
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, var.ipv6_A[count.index])
  assign_ipv6_address_on_creation = true
  tags = {
    Name = var.subnet_nameA[count.index]
  }
  count = 4
}

# Create 4 Subnets on Availablity Zone B
resource "aws_subnet" "subnet_nameB" {
  vpc_id                          = aws_vpc.vpc1.id
  availability_zone               = var.az[1]
  cidr_block                      = var.cidrB[count.index]
  map_public_ip_on_launch         = count.index == 3 ? true : false
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, var.ipv6_B[count.index])
  assign_ipv6_address_on_creation = true
  tags = {
    Name = var.subnet_nameB[count.index]
  }
  count = 4
}

# Create 4 Subnets on Availablity Zone C
resource "aws_subnet" "subnet_nameC" {
  vpc_id                          = aws_vpc.vpc1.id
  availability_zone               = var.az[2]
  cidr_block                      = var.cidrC[count.index]
  map_public_ip_on_launch         = count.index == 3 ? true : false
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, var.ipv6_C[count.index])
  assign_ipv6_address_on_creation = true
  tags = {
    Name = var.subnet_nameC[count.index]
  }
  count = 4
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "a4l-vpc1-igw"
  }
}

# Create Route Table for Web App Subnets
resource "aws_route_table" "webapp" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "a4l-vpc1-rt-web"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_nameA[3].id
  route_table_id = aws_route_table.webapp.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_nameB[3].id
  route_table_id = aws_route_table.webapp.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet_nameC[3].id
  route_table_id = aws_route_table.webapp.id
}

resource "aws_instance" "myec2" {
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_nameA[3].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = var.mykeypair
  tags = {
    Name = "A4L-BASTION-GITACTIONS TEST1"
  }
}

# Configure Security Group and rules for Bastion Host
resource "aws_security_group" "bastion" {
  name        = "BastionSG"
  description = "Allow SSH traffic on Bastion host"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description      = "SSH to Bastion Host"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "BastionSG"
  }
}


