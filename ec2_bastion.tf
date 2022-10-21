resource "aws_instance" "myec2" {
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_nameA[3].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = var.mykeypair
  tags = {
    Name = "A4L-BASTION"
  }
}
