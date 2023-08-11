terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }

    eksctl = {
      source = "mumoshu/eksctl"
      version = "0.17.0"
    }
  }

  backend "s3" {}
}
