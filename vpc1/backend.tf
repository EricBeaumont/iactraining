terraform {
  backend "s3" {
    bucket = "mybucketdeformationtf01tfstate"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
