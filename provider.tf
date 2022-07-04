terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  access_key = "AKIAYRGWDHUQLTQUJ5AW"
  secret_key = "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"
}