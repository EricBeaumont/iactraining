provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "vpc_eric" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name       = "vpc_eric"
    CostCenter = "${var.TagCostCenter}"
  }
}

resource "aws_subnet" "subnet_eric" {
  count             = 2
  vpc_id            = "${aws_vpc.vpc_eric.id}"
  cidr_block        = "${element(var.subnet_cidr,count.index)}"
  availability_zone = "${element(var.my_azs,count.index)}"

  tags {
    Name       = "subnet_eric"
    CostCenter = "${var.TagCostCenter}"
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

resource "aws_route_table_association" "route_association_eric" {
  count          = 2
  subnet_id      = "${element(aws_subnet.subnet_eric.*.id,count.index)}"
  route_table_id = "${aws_route_table.route_eric.id}"
}
