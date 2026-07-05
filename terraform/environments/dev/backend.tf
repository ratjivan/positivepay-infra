terraform {
  backend "s3" {
    bucket       = "account-recon-terraform-state"
    key          = "env/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}