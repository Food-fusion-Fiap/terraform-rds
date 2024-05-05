terraform {
  backend "s3" {
    bucket = "terraform-github-action"
    key    = "prod/terraform-posgres.tfstate"
    region = var.region
  }
}
