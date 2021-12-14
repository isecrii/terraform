variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "igw_id" {
  type        = string
  description = "The ID of the IGW"
}

variable "public_rt" {
  type        = string
  description = "The ID of the Public Route Table"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "env" {
  type        = string
  description = "Environment where the resources are deployed"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
