provider "aws" {
  region = "eu-west-1"
}


module "frontend" {
source="../modules/vpc"
region = "eu-west-1"

vpc_cidr = "10.1.0.0/16"

subnet_cidr = [
"10.1.1.0/24",
"10.1.10.0/24"
]


my_azs = [
"eu-west-1a",
"eu-west-1b"
]

TagCostCenter="mynewcostcenter"
}
