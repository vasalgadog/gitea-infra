terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }/*,
    google = {
      source  = "hashicorp/google"
    }*/
  }
}

#Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "default"
}

/*
provider "google" {
  credentials = file("~/.gcp/credentials.json")
  project     = var.gcp_project
  region      = var.gcp_region
}
*/