resource "google_compute_instance" "db" {
  name         = "reddit-db-${var.env}"
  machine_type = "g1-small"
  zone         = var.zone
  tags = [
  "reddit-db-${var.env}"]
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
 }
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-${var.env}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db-${var.env}"]
  source_tags = ["reddit-app-${var.env}"]
}
