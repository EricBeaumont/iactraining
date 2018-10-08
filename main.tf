provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "vpc_eric" {
  cidr_block = "172.23.0.0/16"

  tags {
    Name       = "vpc_eric"
    CostCenter = "mycostcenter"
  }
}
