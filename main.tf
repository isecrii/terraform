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

resource "aws_security_group" "terraform_web_SG" {
  name   = var.web_sg
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "terraform-web-SG"
    },
    var.tags
  )
}

resource "aws_security_group" "terraform_db_SG" {
  name   = var.db_sg
  vpc_id = var.vpc_id


  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = ["50.73.96.130/32"]
    security_groups = [aws_security_group.terraform_web_SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "terraform-db-SG"
    },
    var.tags
  )
}

output "out_db_sg_id" {
  value = aws_security_group.terraform_db_SG[*].id
}
output "out_web_sg_id" {
  value = aws_security_group.terraform_web_SG[*].id
}
