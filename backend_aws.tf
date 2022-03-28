terraform {
  backend "s3" {
    bucket = "##your bucket name##"
    key    = "terraform.tfstate"
    region = "##your region to provision##"
  }
}