
# locals {
#   amr_dr = {
#     "rackspace-amr-enabled"  = "true"
#     "rackspace-amr-severity" = "low"
#   }
# }

# resource "google_container_cluster" "amr_dr" {
#   provider                 = google-beta
#   location                 = var.primary_region
#   name                     = var.gke_cluster_name
#   description              = var.gke_cluster_name
#   network                  = google_compute_network.amr_vpc.id
#   subnetwork               = google_compute_subnetwork.amr_vpc_subnetwork_public.name
#   logging_service          = var.gke_logging_service
#   monitoring_service       = var.gke_monitoring_service
#   min_master_version       = var.gke_version
#   remove_default_node_pool = true
#   initial_node_count       = 1
#   resource_labels          = merge(var.general_labels, local.amr_dr)

#   vertical_pod_autoscaling {
#     enabled = true
#   }

#   ip_allocation_policy {
#     cluster_secondary_range_name  = google_compute_subnetwork.amr_vpc_subnetwork_public.secondary_ip_range[0].range_name
#     services_secondary_range_name = google_compute_subnetwork.amr_vpc_subnetwork_public.secondary_ip_range[0].range_name
#   }

#   private_cluster_config {
#     enable_private_endpoint = false
#     enable_private_nodes    = false
#   }

#   cluster_autoscaling {
#     enabled = true
#     resource_limits {
#       resource_type = "cpu"
#       minimum       = 3
#       maximum       = 9
#     }
#     resource_limits {
#       resource_type = "memory"
#       minimum       = 3
#       maximum       = 27
#     }
#   }

#   addons_config {
#     http_load_balancing {
#       disabled = false
#     }

#     horizontal_pod_autoscaling {
#       disabled = false
#     }
#     network_policy_config {
#       disabled = false
#     }
#     istio_config {
#       disabled = false
#     }
#   }

#   network_policy {
#     enabled  = true
#     provider = "CALICO"
#   }

#   dynamic "master_authorized_networks_config" {
#     for_each = var.gke_master_authorized_networks_config
#     content {
#       dynamic "cidr_blocks" {
#         for_each = lookup(master_authorized_networks_config.value, "cidr_blocks", [])
#         content {
#           cidr_block   = cidr_blocks.value.cidr_block
#           display_name = lookup(cidr_blocks.value, "display_name", null)
#         }
#       }
#     }
#   }

#   maintenance_policy {
#     daily_maintenance_window {
#       start_time = "03:00"
#     }
#   }

#   lifecycle {
#     ignore_changes = [
#       node_config
#     ]
#   }
# }

# resource "google_service_account" "gke_service_account" {
#   account_id   = "gke-node-sa"
#   display_name = "GKE Cluster Service Account"
# }

# resource "google_project_iam_member" "gke_service_account_roles" {
#   for_each = toset(var.gke_service_account_roles)
#   role     = each.value
#   member   = "serviceAccount:${google_service_account.gke_service_account.email}"
# }

# resource "google_container_node_pool" "node_pool_01" {
#   provider           = google-beta
#   location           = var.primary_region
#   name               = "${var.gke_cluster_name}-pool01"
#   cluster            = google_container_cluster.amr_dr.name
#   initial_node_count = "1"

#   autoscaling {
#     min_node_count = var.gke_autoscaling_min_node_count
#     max_node_count = var.gke_autoscaling_max_node_count
#   }

#   management {
#     auto_repair  = true
#     auto_upgrade = false
#   }

#   node_config {
#     image_type   = "COS"
#     machine_type = var.gke_machine_type
#     disk_size_gb = "30"
#     disk_type    = "pd-standard"
#     preemptible  = false
#     labels       = merge(var.general_labels, local.amr_dr)

#     service_account = google_service_account.gke_service_account.email

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform",
#       "https://www.googleapis.com/auth/compute",
#       "https://www.googleapis.com/auth/devstorage.full_control",
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#       "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
#     ]
#   }

#   lifecycle {
#     ignore_changes = [initial_node_count]
#   }

#   timeouts {
#     create = "30m"
#     update = "30m"
#     delete = "30m"
#   }
# }
