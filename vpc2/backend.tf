terraform {
  backend "s3" {
    bucket = "mybucketdeformationtf01tfstate"
    key    = "vpc2/terraform.tfstate"
    region = "eu-west-1"
  }
}
