variable zone {
  description = "Zone"
  default     = "europe-west1-1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}
variable env {
  description = "Environment"
  default     = ""
}
