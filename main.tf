terraform {
  backend "s3" {
    bucket = "terraform-github-action"
    key    = "prod/terraform-postgres.tfstate"
    region = "us-east-1"
  }
}
