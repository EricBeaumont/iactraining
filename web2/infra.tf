provider "aws" {
  region = "eu-west-1"
}


module "webapp2" {
source="../modules/webapp"
region = "eu-west-1"
type_instance="t2.micro"
my_ami=["lawebappderic_1539177541"]
TagCostCenter="mynewcostcenter"
ami_owners=["self"]
Username="Eric2"
my_azs=["eu-west-1a","eu-west-1b"]
elb_listener_port=80
elb_name="elb-app"
elb_protocol="http"
elb_lb_port=8000
elb_lb_protocol="http"
elb_healthy_threshold=2
elb_unhealthy_threshold=3
elb_timeout=30
elb_target="http:8000/"
elb_interval=60


}
