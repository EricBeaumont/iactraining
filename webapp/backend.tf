terraform {
  backend "s3" {
    bucket = "mybucketdeformationtf01tfstate"
    key    = "webapp/terraform.tfstate"
    region = "eu-west-1"
  }
}

