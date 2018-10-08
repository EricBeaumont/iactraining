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
  vpc_id            = "${aws_vpc.vpc_eric.id}"
  cidr_block        = "172.23.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name       = "subnet_eric"
    CostCenter = "mycostcenter"
  }
}

resource "aws_internet_gateway" "gw_eric" {
  vpc_id = "${aws_vpc.vpc_eric.id}"

  tags {
    Name       = "gw_eric"
    CostCenter = "mycostcenter"
  }
}

resource "aws_route_table" "route_eric" {
  vpc_id = "${aws_vpc.vpc_eric.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw_eric.id}"
  }

  tags {
    Name       = "route_eric"
    CostCenter = "mycostcenter"
  }
}
