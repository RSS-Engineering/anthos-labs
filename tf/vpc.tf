resource "google_compute_network" "primary_vpc" {
  name                    = var.primary_vpc.name
  description             = var.primary_vpc.description
  project                 = var.gcp_project_id
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_router" "primary_vpc_router" {
  name    = "${var.primary_vpc.name}-router"
  network = google_compute_network.primary_vpc.self_link
  region  = var.primary_region
}

resource "google_compute_subnetwork" "primary_vpc_subnetwork_public" {
  name                     = "${var.primary_vpc.name}-subnetwork-public"
  network                  = google_compute_network.primary_vpc.self_link
  private_ip_google_access = true

  ip_cidr_range = var.primary_vpc.public_general
  region        = var.primary_region

  secondary_ip_range {
    range_name    = "public-services"
    ip_cidr_range = var.primary_vpc.public_services
  }

  secondary_ip_range {
    range_name    = "pod-services"
    ip_cidr_range = var.primary_vpc.pod_services
  }
}

resource "google_compute_router_nat" "primary_vpc_nat" {
  name                               = "${var.primary_vpc.name}-nat"
  router                             = google_compute_router.primary_vpc_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.primary_vpc_subnetwork_public.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  region = var.primary_region

}

resource "google_compute_subnetwork" "primary_vpc_subnetwork_private" {
  name                     = "${var.primary_vpc.name}-subnetwork-private"
  network                  = google_compute_network.primary_vpc.self_link
  private_ip_google_access = "true"
  region                   = var.primary_region

  ip_cidr_range = var.primary_vpc.private_general

  secondary_ip_range {
    range_name    = "private-services"
    ip_cidr_range = var.primary_vpc.private_services
  }

}



resource "google_compute_network" "secondary_vpc" {
  name                    = var.secondary_vpc.name
  description             = var.secondary_vpc.description
  project                 = var.gcp_project_id
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_router" "secondary_vpc_router" {
  name    = "${var.secondary_vpc.name}-router"
  network = google_compute_network.secondary_vpc.self_link
  region  = var.secondary_region
}

resource "google_compute_subnetwork" "secondary_vpc_subnetwork_public" {
  name                     = "${var.secondary_vpc.name}-subnetwork-public"
  network                  = google_compute_network.secondary_vpc.self_link
  private_ip_google_access = true

  ip_cidr_range = var.secondary_vpc.public_general
  region        = var.secondary_region
  secondary_ip_range {
    range_name    = "public-services"
    ip_cidr_range = var.secondary_vpc.public_services
  }

  secondary_ip_range {
    range_name    = "pod-services"
    ip_cidr_range = var.secondary_vpc.pod_services
  }

}

resource "google_compute_router_nat" "secondary_vpc_nat" {
  name                               = "${var.secondary_vpc.name}-nat"
  router                             = google_compute_router.secondary_vpc_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.secondary_vpc_subnetwork_public.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  region = var.secondary_region
}

resource "google_compute_subnetwork" "secondary_vpc_subnetwork_private" {
  name                     = "${var.secondary_vpc.name}-subnetwork-private"
  network                  = google_compute_network.secondary_vpc.self_link
  private_ip_google_access = "true"
  region                   = var.secondary_region

  ip_cidr_range = var.secondary_vpc.private_general
  secondary_ip_range {
    range_name    = "private-services"
    ip_cidr_range = var.secondary_vpc.private_services
  }
}
