resource "google_compute_instance" "app" {
  name         = "reddit-app-${var.env}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app-${var.env}"]
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
}
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip-${var.env}"
}
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-${var.env}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app-${var.env}"]
}
