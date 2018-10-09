output "vpc_id" {
  value = "${aws_vpc.vpc_eric.id}"
}

output "subnet_id" {
  value = "${aws_subnet.subnet_eric.*.id}"
}
