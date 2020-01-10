variable zone {
  description = "Zone"
  default     = "europe-west1-1"
}
variable source_ranges {
description = "Allowed IP addresses"
default = ["0.0.0.0/0"]
}
variable env {
  description = "Environment"
  default = ""
}
