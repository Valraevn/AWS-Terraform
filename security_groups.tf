// SSH
#resource "aws_security_group" "allow_ssh" {
resource "aws_default_security_group" "allow_ssh" {
  #name        = "allow_ssh"
  #description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main_network.id
  ingress {
    description      = "Allow SSH"
    from_port        = "22"
    to_port          = "22"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #cidr_blocks      = [aws_subnet.public_subnet.cidr_block]
  }
  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #cidr_blocks      = [aws_subnet.public_subnet.cidr_block]
  }
  tags = {
    Name = "allow_ssh"
  }
}
