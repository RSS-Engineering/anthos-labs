
resource "google_compute_firewall" "allow-bastion-ssh" {
  name    = "bastion-allow-ssh"
  network = google_compute_network.primary_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "allow-iap-ssh" {
  name    = "iap-allow-ssh"
  network = google_compute_network.primary_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}