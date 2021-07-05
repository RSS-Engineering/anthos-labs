module "acm-primary" {
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/acm"

  project_id       =  var.gcp_project_id
  cluster_name     = module.primary-cluster.name
  location         = module.primary-cluster.location
  cluster_endpoint = module.primary-cluster.endpoint

  operator_path    = "config-management-operator.yaml"
  sync_repo        = var.primary_acm.repo
  sync_branch      = var.primary_acm.branch
  policy_dir       = var.primary_acm.dir
}

module "acm-secondary" {
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/acm"

  project_id       =  var.gcp_project_id
  cluster_name     = module.secondary-cluster.name
  location         = module.secondary-cluster.location
  cluster_endpoint = module.secondary-cluster.endpoint

  operator_path    = "config-management-operator.yaml"
  sync_repo        = var.secondary_acm.repo
  sync_branch      = var.secondary_acm.branch
  policy_dir       = var.secondary_acm.dir
}