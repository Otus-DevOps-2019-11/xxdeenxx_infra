variable zone {
  description = "Zone"
  default     = "europe-west1-1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
description = "Disk image for reddit app"
default = "reddit-base-app"
}
variable env {
description = "Environment"
default = ""
}
