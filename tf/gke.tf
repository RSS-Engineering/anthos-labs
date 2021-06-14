# Primary Cluster
module "primary-cluster" {
  name                    = "primary"
  project_id              = var.gcp_project_id
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  version                 = "13.0.0"
  regional                = false
  region                  = var.primary_region
  network                 = google_compute_network.primary_vpc.name
  subnetwork              = google_compute_subnetwork.primary_vpc_subnetwork_public.name
  ip_range_pods           = "pod-services"
  ip_range_services       = "public-services"
  zones                   = var.primary_zones
  release_channel         = "REGULAR"
  cluster_resource_labels = { "mesh_id" : "proj-${data.google_project.project.number}" }
  node_pools = [
    {
      name         = "default-node-pool"
      autoscaling  = false
      auto_upgrade = true

      node_count   = 5
      machine_type = "e2-standard-4"
    },
  ]

}

# Secondary Cluster
module "secondary-cluster" {
  name                    = "secondary"
  project_id              = var.gcp_project_id
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  version                 = "13.0.0"
  regional                = false
  region                  = var.secondary_region
  network                 = google_compute_network.secondary_vpc.name
  subnetwork              = google_compute_subnetwork.secondary_vpc_subnetwork_public.name
  ip_range_pods           = "pod-services"
  ip_range_services       = "public-services"
  zones                   = var.secondary_zones
  release_channel         = "REGULAR"
  cluster_resource_labels = { "mesh_id" : "proj-${data.google_project.project.number}" }

  node_pools = [
    {
      name         = "default-node-pool"
      autoscaling  = false
      auto_upgrade = true

      node_count   = 5
      machine_type = "e2-standard-4"
    },
  ]

}
