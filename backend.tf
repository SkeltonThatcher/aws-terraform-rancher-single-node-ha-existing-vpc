terraform {
  backend "s3" {
    bucket = "terraform-state-data-connected-tools"
    key    = "rancher"
    region = "eu-west-1"
  }
}
