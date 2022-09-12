locals {
  prefix = "${terraform.workspace}-${var.prefix}"
  common_tags = {
    ManagedBy   = "Wilberson"
    Department  = "DevOps",
    Provider    = "PUC Minas",
    Owner       = "Time de DevOps"
    Billing     = "Infrastructure"
    Environment = terraform.workspace
    UserEmail   = "infraestrutura@gmail.com"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.27"
    }
  }
  backend "s3" {
    bucket = "tfstate-pucminas-devops"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_chave_acesso_id
  secret_key = var.aws_chave_acesso
}