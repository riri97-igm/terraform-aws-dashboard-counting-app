# VPC and Networking Resources for Counting Dashboard

resource "aws_vpc" "dashboard-counting-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "${var.environment}"
  }
}

# Subnets for public and private (Dashboard & Counting Application)

resource "aws_subnet" "dashboard-subnet" {
  vpc_id     = aws_vpc.dashboard-counting-vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    name = "${var.prefix}-public-subnet"
  }
}

resource "aws_subnet" "counting-subnet" {
  vpc_id     = aws_vpc.dashboard-counting-vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    name = "${var.prefix}-private-subnet"
  }
}

# Security Group for Dashboard and Counting Application

resource "aws_security_group" "sg-dashboard" {
  name   = "dashboard-security-group"
  vpc_id = aws_vpc.dashboard-counting-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    from_port   = 9002
    to_port     = 9002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "dashboard-security-group"
  }
}

resource "aws_security_group" "sg-counting" {
  name = "Counting-security-group"

  vpc_id = aws_vpc.dashboard-counting-vpc.id

  ingress {
    description = "Allow SSH from public subnet or bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  ingress {
    description     = "Allow dashboard app to access counting app"
    from_port       = 9003
    to_port         = 9003
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-dashboard.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "Dashboard-security-group"
  }
}

# Internet Gateway for VPC to allow outbound internet access for public subnet and NAT Gateway
resource "aws_internet_gateway" "counting-dashboard-igw" {
  vpc_id = aws_vpc.dashboard-counting-vpc.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.prefix}-nat-eip"
  }
}

# NAT Gateway in public subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.dashboard-subnet.id

  tags = {
    Name = "${var.prefix}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.counting-dashboard-igw]
}

# Public route table default route to Internet Gateway
resource "aws_route_table" "counting-dashboard-rt" {
  vpc_id = aws_vpc.dashboard-counting-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.counting-dashboard-igw.id
  }
}
# Associate public subnet with public route table
resource "aws_route_table_association" "counting-dashboard" {
  subnet_id      = aws_subnet.dashboard-subnet.id
  route_table_id = aws_route_table.counting-dashboard-rt.id
}

# Private route table default route to NAT Gateway
resource "aws_route_table" "counting-private-rt" {
  vpc_id = aws_vpc.dashboard-counting-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}
# Associate private subnet with private route table
resource "aws_route_table_association" "counting_dashboard_private_assoc" {
  subnet_id      = aws_subnet.counting-subnet.id
  route_table_id = aws_route_table.counting-private-rt.id
}