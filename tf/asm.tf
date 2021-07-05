module "asm-primary" {
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/asm"
  project_id       =  var.gcp_project_id
  cluster_name     = module.primary-cluster.name
  location         = module.primary-cluster.location
  cluster_endpoint = module.primary-cluster.endpoint
  enable_all            = false
  enable_cluster_roles  = true
  enable_cluster_labels = false
  enable_gcp_apis       = false
  enable_gcp_iam_roles  = false
  enable_gcp_components = true
  enable_registration   = false
  managed_control_plane = false
  skip_validation       = true
  outdir          = "asm-dir-${module.primary-cluster.name}"
}

module "asm-secondary" {
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/asm"
  project_id       = var.gcp_project_id
  cluster_name     = module.secondary-cluster.name
  location         = module.secondary-cluster.location
  cluster_endpoint = module.secondary-cluster.endpoint

  enable_all            = false
  enable_cluster_roles  = true
  enable_cluster_labels = false
  enable_gcp_apis       = false
  enable_gcp_iam_roles  = false
  enable_gcp_components = true
  enable_registration   = false
  managed_control_plane = false
  skip_validation       = true
  outdir = "asm-dir-${module.secondary-cluster.name}"
}