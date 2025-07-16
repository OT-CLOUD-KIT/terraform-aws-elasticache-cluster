terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket"
    key    = "ot/module/Elastic-cluster/terraform.tfstate"
    region = "us-east-1"

  }
}