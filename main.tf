terraform {
  backend "s3" {}
  required_version = ">= 0.13.0"
  required_providers {
    aws = "~> 3.20.0"
  }
}
