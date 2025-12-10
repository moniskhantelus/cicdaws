terraform {
  backend "s3" {
    bucket         = "monis-terraform-backend"
    key            = "cicdaws/terraform.tfstate"
    region         = "us-east-1"
  //  dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}
