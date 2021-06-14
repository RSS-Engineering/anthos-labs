module "project-services" {
  source     = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id = var.gcp_project_id

  activate_apis               = var.gcp_service_list
  disable_services_on_destroy = false
  disable_dependent_services  = false
}