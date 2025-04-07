# Allocate Elastic IP for NAT Gateway AZ1
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc = true

  tags = {
    Name = "eip-nat-az1"
  }
}

# Allocate Elastic IP for NAT Gateway AZ2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc = true

  tags = {
    Name = "eip-nat-az2"
  }
}

# NAT Gateway in Public Subnet AZ1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "nat-gateway-az1"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

# NAT Gateway in Public Subnet AZ2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id

  tags = {
    Name = "nat-gateway-az2"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

# Private Route Table AZ1 with NAT Gateway
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }

  tags = {
    Name = "private-rt-az1"
  }
}

# Associate Private App Subnet AZ1 with Route Table AZ1
resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# Associate Private Data Subnet AZ1 with Route Table AZ1
resource "aws_route_table_association" "private_data_subnet_az1_route_table_az1_association" {
  subnet_id      = aws_subnet.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# Private Route Table AZ2 with NAT Gateway
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }

  tags = {
    Name = "private-rt-az2"
  }
}

# Associate Private App Subnet AZ2 with Route Table AZ2
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}

# Associate Private Data Subnet AZ2 with Route Table AZ2
resource "aws_route_table_association" "private_data_subnet_az2_route_table_az2_association" {
  subnet_id      = aws_subnet.private_data_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
}
