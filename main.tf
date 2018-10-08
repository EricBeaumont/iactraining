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

resource "aws_subnet" "subnet_eric" {
  vpc_id     = "${aws_vpc.vpc_eric.id}"
  cidr_block = "172.23.1.0/24"

  tags {
    Name       = "subnet_eric"
    CostCenter = "mycostcenter"
  }
}
