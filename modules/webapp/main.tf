provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "ami_eric" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.my_ami}"]
  }

  owners = ["099720109477"]
}

data "template_file" "template_user" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

  vars {
    username = "${var.Username}"
  }
}

data "aws_subnet_ids" "subnet_webapp" {
  vpc_id = "${data.aws_vpc.vpc_eric.id}"
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
  subnet_id                   = ["${element(data.aws_subnet_ids.subnet_webapp.ids,count.index)}"
  security_groups             = ["${aws_security_group.security_app.id}"]
  associate_public_ip_address = true
  user_data                   = "${data.template_file.template_user.rendered}"
  count                       = "${length(data.aws_subnet_ids.subnet_webapp.ids)}"

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

resource "aws_elb" "elb_eric" {
  name               = "${var.elb_name}"
subnets= "${element(data.aws_subnet_ids.subnet_webapp.ids,count.index)}"

  listener {
    instance_port     = "${var.elb_listener_port}"
    instance_protocol = "${var.elb_protocol}"
    lb_port           = "${var.elb_lb_port}"
    lb_protocol       = "${var.elb_lb_protocol}"
  }

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_timeout}"
    target              = "${var.elb_target}"
    interval            = "${var.elb_interval}"
  }

  tags {
    CostCenter = "${var.TagCostCenter}"
  }
}
