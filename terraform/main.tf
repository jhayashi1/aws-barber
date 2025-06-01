provider "aws" {
	region = "us-east-1"

    default_tags {
        tags = {
            Name = "barber"
            git_url = "https://github.com/jhayashi1/was-barber"
        }
    }
}

terraform {
    backend "s3" {
        bucket = "jhayashi-terraform-state"
        acl = "bucket-owner-full-control"
        encrypt = true
        region = "us-east-1"
        key = "barber"
    }
}

data "aws_caller_identity" "current" {}