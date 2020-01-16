resource "google_compute_instance_group" "apps" {
  name      = "app-group"
  zone      = var.zone
  instances = google_compute_instance.app[*].self_link

  named_port {
    name = var.service_port_name
    port = var.service_port
  }
}

module "gce-lb-http" {
  source      = "GoogleCloudPlatform/lb-http/google"
  name        = "group-http-lb"
  project     = var.project
  target_tags = [var.backend]
  backends = {
    default = {
      description                     = null
      protocol                        = "HTTP"
      port                            = var.service_port
      port_name                       = var.service_port_name
      timeout_sec                     = 10
      connection_draining_timeout_sec = null
      enable_cdn                      = false

      health_check = {
        check_interval_sec  = 10
        timeout_sec         = 5
        healthy_threshold   = 2
        unhealthy_threshold = 3
        request_path        = "/"
        port                = var.service_port
        host                = null
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = "${google_compute_instance_group.apps.self_link}"
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]
    }
  }
}
