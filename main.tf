# 1. Configure the provider
provider "aws" {
  region  = "us-west-2"           # Changed from "us-switch" to a valid region
  profile = "terraform-user"
}

# 2. Store the Terraform state file in S3
terraform {
  backend "s3" {
    bucket  = "monotext77-terraform-resets-state"
    key     = "terraform.titrate.dev/terraform.tfstate"
    region  = "us-west-2"         # Also matched with the provider region
    profile = "terraform-user"
  }
}
