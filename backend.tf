terraform {
  backend "s3" {
    bucket = "terraform-state-manguts"
    key = "vpc_bastion/terraform.tfstate"    #project_name/terraform.tfstate
    region = "us-east-1"
    #dynamodb_table = "terraform-state-locking"
  }
}

