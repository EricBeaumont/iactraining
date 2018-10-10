provider "aws" {
  region = "eu-west-1"
}


module "webapp2" {
source="../modules/webapp"
region = "eu-west-1"
type_instance="t2.micro"
my_ami=["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
TagCostCenter="mynewcostcenter"

Username="Eric2"
my_azs=["eu-west-1a","eu-west-1b"]
elb_listener_port=8000
elb_name="elb-app"
elb_protocol="http"
elb_lb_port=80
elb_lb_protocol="http"
elb_healthy_threshold=2
elb_unhealthy_threshold=3
elb_timeout=30
elb_target="http:8000/"
elb_interval=60


}
