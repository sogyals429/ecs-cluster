terraform {
  backend "s3" {
    bucket = "terraform-ecs-sogyal"
    key = "terraform.tfstate.d"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

locals {
  common_tags = {
    Project = "terraform-aws-vpn"
    Maintainer_Software = "Terraform"
    Project = "git@github.com:sogyals429/terraform-aws-vpn.git"
  }
}
