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
