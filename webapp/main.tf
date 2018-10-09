provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "ami_eric" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*"]
  }

  owners = ["099720109477"]
}

data "template_file" "template_user" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

  vars {
    username = "eric"
  }
}

data "aws_subnet" "subnet_webapp" {
  filter {
    name   = "subnet-id"
    values = ["subnet-03504c3a223ef2773"]
  }
}

data "aws_vpc" "vpc_eric" {
  filter {
    name   = "tag:Name"
    values = ["vpc_eric"]
  }
}

resource "aws_instance" "ec2_eric" {
  ami           = "${data.aws_ami.ami_eric.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet.subnet_webapp.id}"

  tags {
    Name       = "WebApp"
    CostCenter = "mycostcenter"
  }
}

resource "aws_security_group" "security_app" {
  name        = "security_app"
  description = "filter inbound traffic"
  vpc_id      = "${data.aws_vpc.vpc_eric.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
