terraform {
  backend "s3" {
    bucket = "existing_bucket_name_here"
    key    = "rancher"
    region = "eu-west-1"
  }
}
