terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
}

# create a random string for appending to resuorces that require uniqueness globally
resource "random_string" "this" {
  length           = 8
  special          = true
  override_special = "-"
}
