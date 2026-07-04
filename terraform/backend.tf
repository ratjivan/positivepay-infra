terraform {
  backend "s3" {
    bucket         = "account-recon-terraform-statet"
    key            = "env/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}