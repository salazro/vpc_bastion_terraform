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