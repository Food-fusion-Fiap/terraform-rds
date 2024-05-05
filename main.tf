terraform {
  backend "s3" {
    bucket = "terraform-github-action"
    key    = "prod/terraform-posgres.tfstate"
    region = "us-east-1"
  }
}
