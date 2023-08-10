terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.1.0"
    }
    eksctl = {
      source = "mumoshu/eksctl"
      version = "0.17.0"
    }
  }

  backend "s3" {}
}
