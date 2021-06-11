module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "10.1.1"
  project_id                  = var.gcp_project_id

  activate_apis = var.gcp_service_list
}