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

