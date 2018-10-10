variable "region" {
  type = "string"
}

variable "ami_owners" {
type="list"
}

variable "type_instance" {
  type = "string"
}

variable "TagCostCenter" {
  type = "string"
}

variable "Username" {
  type = "string"
}

variable "my_ami" {
  type = "list"
}

variable "elb_listener_port" {
  type = "string"
}

variable "my_azs" {
  type = "list"
}

variable "elb_name" {
  type = "string"
}

variable "elb_protocol" {
  type = "string"
}

variable "elb_lb_port" {
  type = "string"
}

variable "elb_lb_protocol" {
  type = "string"
}

variable "elb_healthy_threshold" {
  type = "string"
}

variable "elb_unhealthy_threshold" {
  type = "string"
}

variable "elb_timeout" {
  type = "string"
}

variable "elb_target" {
  type = "string"
}

variable "elb_interval" {
  type = "string"
}
