terraform {
  required_version = ">=0.12.0"
}
provider "google" {
  version = ">=2.15"
  project = var.project
  region  = var.region
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  env             = "prod"
}
module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  env             = "prod"
}
module "vpc" {
  source        = "../modules/vpc"
  zone          = var.zone
  source_ranges = ["80.92.238.217/32"]
  env           = "prod"
}
