terraform {
  required_version = ">= 0.12"
}
provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}
provider "random" {
  version = "~> 2.2"
}
module "storage-bucket" {
  source        = "SweetOps/storage-bucket/google"
  version       = "0.3.0"
  name          = "deen-bucket-test"
  location      = var.location
  force_destroy = true
}
output storage-bucket_url {
  value = module.storage-bucket.url
}
