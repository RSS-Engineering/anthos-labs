# resource "google_service_account" "bastion" {
#   account_id   = "bastion"
#   display_name = "Bastion service account"
# }

# data "google_iam_policy" "bastion" {

#   binding {
#     role = "roles/storage.legacyBucketReader"
#     members = [
#       "serviceAccount:${google_service_account.bastion.email}"
#     ]
#   }
#   binding {
#     role = "roles/storage.legacyObjectReader"
#     members = [
#       "serviceAccount:${google_service_account.bastion.email}"
#     ]
#   }
# }

# locals {
#   bastion_labels = {
#     "rackspace-amr-enabled"  = "true"
#     "rackspace-amr-severity" = "low"
#   }
# }

# resource "google_compute_instance_template" "bastion" {
#   name_prefix          = "bastion-"
#   description          = "Bastion Temmplate."
#   instance_description = "Bastion"
#   machine_type         = "n1-standard-1"
#   can_ip_forward       = false
#   labels               = merge(var.general_labels, local.bastion_labels)
#   tags                 = ["bastion"]

#   lifecycle {
#     create_before_destroy = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${var.ssh_key_public}"
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#   }

#   // Create a new boot disk from an image
#   disk {
#     source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20210211" #data.google_compute_image.bastion.self_link
#     auto_delete  = true
#     boot         = true
#   }

#   network_interface {
#     network    = google_compute_network.amr_vpc.name
#     subnetwork = google_compute_subnetwork.amr_vpc_subnetwork_public.name
#     access_config {
#     }
#   }

#   service_account {
#     email  = google_service_account.bastion.email
#     scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }

#   metadata_startup_script = <<EOF
# #! /bin/bash
# sudo apt-get update
# echo "startup:success" > /tmp/startup-status
# EOF

# }

# data "google_compute_image" "bastion" {
#   family  = var.bastion_os_family
#   project = var.bastion_os_project
# }

# resource "google_compute_target_pool" "bastion_pool" {
#   name = "bastion-pool"
# }

# resource "google_compute_instance_group_manager" "bastion" {
#   provider = google-beta

#   name               = "bastion01"
#   base_instance_name = "bastion"
#   zone               = "${var.primary_region}-${var.bastion_zone}"
#   target_size        = 1
#   target_pools       = [google_compute_target_pool.bastion_pool.self_link]

#   version {
#     name              = "bastion"
#     instance_template = google_compute_instance_template.bastion.self_link
#   }
#   #  auto_healing_policies {
#   #    health_check      = google_compute_health_check.bastion_ssh.id
#   #    initial_delay_sec = 300
#   #  }
# }

