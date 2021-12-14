variable "vpc_id" {
  type = string
  default = aws_vpc.vpc.id

}

variable "tags" {
  type = map(string)
  default = {
    Creator = "Irina Secrii"
    User    = "isecrii"
    Owner   = "Irina-Secrii"
    Team    = "DevOps"
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443, 22]
}

variable "public_subnet_cidr" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}

variable "public_az" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "private_az" {
  type = list(string)
  default = [
    "us-east-1d",
    "us-east-1e",
    "us-east-1f"
  ]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}
