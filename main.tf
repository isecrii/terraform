################################################################################
# VPC
################################################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name = "vpc-${var.env}"
    },
    var.tags
  )
}

################################################################################
# Internet Gateway
################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "igw-${var.env}"
    },
    var.tags
  )
}

################################################################################
# Public routes
################################################################################
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(
    {
      Name = "public-${var.env}"
    },
    var.tags
  )
}

################################################################################
# Route table association
################################################################################
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  route_table_id = var.public_rt
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

################################################################################
# Public subnet
################################################################################
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  cidr_block              = var.public_subnets[count.index]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.azs[count.index]

  tags = merge(
    {
      Name = "public-${var.env}"
    },
    var.tags
  )
}
