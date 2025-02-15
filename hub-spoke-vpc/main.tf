provider "aws" {
  region = "ap-south-1"
}

# Hub VPC
resource "aws_vpc" "hub_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "Hub VPC" }
}

resource "aws_subnet" "hub_subnet" {
  vpc_id            = aws_vpc.hub_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags              = { Name = "Hub Subnet" }
}

# Spoke1 VPC
resource "aws_vpc" "spoke1_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "Spoke1 VPC" }
}

resource "aws_subnet" "spoke1_subnet" {
  vpc_id            = aws_vpc.spoke1_vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-south-1a"
  tags              = { Name = "Spoke1 Subnet" }
}

# Spoke2 VPC
resource "aws_vpc" "spoke2_vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "Spoke2 VPC" }
}

resource "aws_subnet" "spoke2_subnet" {
  vpc_id            = aws_vpc.spoke2_vpc.id
  cidr_block        = "10.2.1.0/24"
  availability_zone = "ap-south-1a"
  tags              = { Name = "Spoke2 Subnet" }
}

# VPC Peering: Hub ↔ Spoke1
resource "aws_vpc_peering_connection" "hub_to_spoke1" {
  vpc_id      = aws_vpc.hub_vpc.id
  peer_vpc_id = aws_vpc.spoke1_vpc.id
  auto_accept = true
  tags        = { Name = "Hub-to-Spoke1 Peering" }
}

# VPC Peering: Hub ↔ Spoke2
resource "aws_vpc_peering_connection" "hub_to_spoke2" {
  vpc_id      = aws_vpc.hub_vpc.id
  peer_vpc_id = aws_vpc.spoke2_vpc.id
  auto_accept = true
  tags        = { Name = "Hub-to-Spoke2 Peering" }
}

# Route Tables for Hub VPC
resource "aws_route_table" "hub_rt" {
  vpc_id = aws_vpc.hub_vpc.id
}

resource "aws_route" "hub_to_spoke1_route" {
  route_table_id            = aws_route_table.hub_rt.id
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke1.id
}

resource "aws_route" "hub_to_spoke2_route" {
  route_table_id            = aws_route_table.hub_rt.id
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke2.id
}

resource "aws_route_table_association" "hub_subnet_association" {
  subnet_id      = aws_subnet.hub_subnet.id
  route_table_id = aws_route_table.hub_rt.id
}

# Route Tables for Spoke1
resource "aws_route_table" "spoke1_rt" {
  vpc_id = aws_vpc.spoke1_vpc.id
}

resource "aws_route" "spoke1_to_hub_route" {
  route_table_id            = aws_route_table.spoke1_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke1.id
}

resource "aws_route_table_association" "spoke1_subnet_association" {
  subnet_id      = aws_subnet.spoke1_subnet.id
  route_table_id = aws_route_table.spoke1_rt.id
}

# Route Tables for Spoke2
resource "aws_route_table" "spoke2_rt" {
  vpc_id = aws_vpc.spoke2_vpc.id
}

resource "aws_route" "spoke2_to_hub_route" {
  route_table_id            = aws_route_table.spoke2_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke2.id
}

resource "aws_route_table_association" "spoke2_subnet_association" {
  subnet_id      = aws_subnet.spoke2_subnet.id
  route_table_id = aws_route_table.spoke2_rt.id
}

# Security Group for Hub VPC
resource "aws_security_group" "hub_sg" {
  vpc_id = aws_vpc.hub_vpc.id
  name   = "Hub Security Group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16", "10.2.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private Endpoint for S3 in Hub VPC
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id           = aws_vpc.hub_vpc.id
  service_name     = "com.amazonaws.ap-south-1.s3"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [aws_subnet.hub_subnet.id]
  security_group_ids = [aws_security_group.hub_sg.id]
}

