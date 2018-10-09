terraform {
  backend "s3" {
    bucket = "mybucketdeformationtf01tfstate"
    key    = "webapp2/terraform.tfstate"
    region = "eu-west-1"
  }
}
