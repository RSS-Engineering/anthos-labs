# resource "google_compute_network" "amr_stage_vpc" {
#   provider                = google.stage
#   name                    = "${var.stage_vpc.name}-network"
#   description             = var.stage_vpc.description
#   project                 = var.gcp_stage_project_id
#   auto_create_subnetworks = "false"
#   routing_mode            = "REGIONAL"
# }

# resource "google_compute_router" "amr_stage_vpc_router" {
#   provider = google.stage
#   name     = "${var.stage_vpc.name}-router"
#   network  = google_compute_network.amr_stage_vpc.self_link
# }

# resource "google_compute_subnetwork" "amr_stage_vpc_subnetwork_public" {
#   provider = google.stage-beta

#   name                     = "${var.stage_vpc.name}-subnetwork-public"
#   network                  = google_compute_network.amr_stage_vpc.self_link
#   private_ip_google_access = true

#   ip_cidr_range = cidrsubnet(var.stage_vpc.cidr_block, var.stage_vpc.cidr_subnetwork_width_delta, 0)


#   secondary_ip_range {
#     range_name = "public-services"
#     ip_cidr_range = cidrsubnet(
#       var.stage_vpc.secondary_cidr_block,
#       var.stage_vpc.secondary_cidr_subnetwork_width_delta,
#       0
#     )
#   }
# }

# resource "google_compute_router_nat" "amr_stage_vpc_nat" {
#   provider                           = google.stage
#   name                               = "${var.stage_vpc.name}-nat"
#   router                             = google_compute_router.amr_stage_vpc_router.name
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
#   subnetwork {
#     name                    = google_compute_subnetwork.amr_stage_vpc_subnetwork_public.self_link
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#   }
# }

# resource "google_compute_subnetwork" "amr_stage_vpc_subnetwork_private" {
#   provider = google.stage-beta

#   name                     = "${var.stage_vpc.name}-subnetwork-private"
#   network                  = google_compute_network.amr_stage_vpc.self_link
#   private_ip_google_access = "true"

#   ip_cidr_range = cidrsubnet(
#     var.stage_vpc.cidr_block,
#     var.stage_vpc.cidr_subnetwork_width_delta,
#     1 * (1 + var.stage_vpc.cidr_subnetwork_spacing)
#   )

#   secondary_ip_range {
#     range_name = "private-services"
#     ip_cidr_range = cidrsubnet(
#       var.stage_vpc.secondary_cidr_block,
#       var.stage_vpc.secondary_cidr_subnetwork_width_delta,
#       1 * (1 + var.stage_vpc.secondary_cidr_subnetwork_spacing)
#     )
#   }
# }
