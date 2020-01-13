terraform {
  backend "gcs" {
    bucket = "deen-bucket-env"
    prefix = "state"
  }
}
