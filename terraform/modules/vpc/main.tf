resource "google_compute_firewall" "firewall_ssh" {
  name    = "allow-ssh-${var.env}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.source_ranges
  target_tags = [
    "reddit-app-${var.env}",
    "reddit-db-${var.env}"
  ]
}
