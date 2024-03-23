resource "aws_instance" "cloud_VM" {
  ami		= "ami-0b9932f4918a00c4f"
  instance_type = "t2.nano"
  key_name         = "aws"
  tags = {
    Name = "Cloud_VM"
  }
  network_interface {
    network_interface_id = aws_network_interface.an_interface.id
    device_index = 0
  }
}

// SSH Key pair
resource "aws_key_pair" "aws_key" {
  key_name   = "aws"
  public_key = "<public ssh key>"
}

#resource "aws_network_interface_sg_attachment" "sg_ssh_attachment" {
 # security_group_id = aws_default_security_group.allow_ssh.id
  #network_interface_id = aws_network_interface.an_interface.id
#}
