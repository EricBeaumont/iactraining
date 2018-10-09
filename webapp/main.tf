provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "ami_eric" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
}
