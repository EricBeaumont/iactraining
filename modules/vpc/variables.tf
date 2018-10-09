variable "region" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
}

variable "subnet_cidr" {
  type = "list"
}

variable "my_azs" {
  type = "list"
}

variable "TagCostCenter" {
  type = "string"
}
