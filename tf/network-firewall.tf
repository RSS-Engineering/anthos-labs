

# resource "google_compute_firewall" "allow-httplb-gke" {
#   name    = "httplb-allow-gke"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#   }
#   target_service_accounts = [google_service_account.gke_service_account.email]
#   source_ranges           = var.gcp_http_lb_ranges
# }

# resource "google_compute_firewall" "allow-lamp-http" {
#   name    = "lamp-allow-http"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }
#   target_tags = ["lamp-web"]
# }


# resource "google_compute_firewall" "allow-bastion-ssh" {
#   name    = "bastion-allow-ssh"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   target_tags = ["bastion"]
# }

# resource "google_compute_firewall" "allow-pets-rdp" {
#   name    = "pets-allow-rdp"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["3389"]
#   }
#   target_tags = ["pet03"]
# }

# resource "google_compute_firewall" "allow-iap-ssh" {
#   name    = "iap-allow-ssh"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   source_ranges = ["35.235.240.0/20"]
# }

# resource "google_compute_firewall" "allow-iap-rdp" {
#   name    = "iap-allow-rdp"
#   network = google_compute_network.amr_vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["3389"]
#   }
#   source_ranges = ["35.235.240.0/20"]
# }