provider "aws" {
  region = "eu-west-1"
}


module "webapp2" {
source="../modules/webapp"
region = "eu-west-1"
type_instance="t2.micro"

}
