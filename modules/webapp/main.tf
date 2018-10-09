provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "ami_eric" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "template_file" "template_user" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

  vars {
    username = "${var.Username}"
  }
}

data "aws_subnet" "subnet_webapp" {
  filter {
    name   = "subnet-id"
    values = ["${var.subnet_id}"]
  }
}

data "aws_vpc" "vpc_eric" {
  filter {
    name   = "tag:Name"
    values = ["vpc_eric2"]
  }
}

resource "aws_instance" "ec2_eric" {
  ami                         = "${data.aws_ami.ami_eric.id}"
  instance_type               = "${var.type_instance}"
  subnet_id                   = "${data.aws_subnet.subnet_webapp.id}"
  security_groups             = ["${aws_security_group.security_app.id}"]
  associate_public_ip_address = true

  tags {
    Name       = "WebApp2"
    CostCenter = "${var.TagCostCenter}"
  }
}

resource "aws_security_group" "security_app" {
  name        = "security_app"
  description = "filter inbound traffic"
  vpc_id      = "${data.aws_vpc.vpc_eric.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
