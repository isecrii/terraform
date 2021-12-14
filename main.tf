provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = var.tags

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "rt_assoc" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.my_rt.id
}
