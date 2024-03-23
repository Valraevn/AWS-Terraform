// VPC
resource "aws_vpc" "main_network" {
  cidr_block = "10.56.0.0/16"
  tags = {
    Name = "Main VPC"
  }
}

// Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_network.id
  cidr_block = "10.56.1.0/24"
  tags = {
    Name = "Public_subnet"
  }
  #depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
}

// Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_network.id
  cidr_block = "10.56.2.0/24"
  tags = {
    Name = "Private_subnet"
  }
  #depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
}

// Add public subnet to VPC
#resource "aws_vpc_ipv4_cidr_block_association" "public_subnet" {
#  vpc_id     = aws_vpc.main_network.id
#  cidr_block = aws_subnet.public_subnet.cidr_block
#}

// Add private subnet to VPC
#resource "aws_vpc_ipv4_cidr_block_association" "private_subnet" {
#  vpc_id     = aws_vpc.main_network.id
#  cidr_block = aws_subnet.private_subnet.cidr_block
#}

// Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_network.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
#  route {
#    cidr_block = var.networking.ip-range-tunnel
#    network_interface_id = aws_network_interface.cloud_vpn.id
#  }
}

// Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_network.id
  route {
    cidr_block = aws_subnet.private_subnet.cidr_block
    network_interface_id = aws_network_interface.an_interface.id
  }
}

// Set main route table
resource "aws_main_route_table_association" "public_route_association" {
  vpc_id         = aws_vpc.main_network.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

// Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main_network.id
  tags = {
    Name = "Internet Gateway"
  }
}

// Interface
resource "aws_network_interface" "an_interface" {
  subnet_id = aws_subnet.public_subnet.id
  private_ips = ["10.56.1.5"]
  source_dest_check = false
}

resource "aws_eip" "eip" {
  instance = aws_instance.cloud_VM.id
  domain = "vpc"
}

output "ip" {
  value = aws_eip.eip.public_ip
}
