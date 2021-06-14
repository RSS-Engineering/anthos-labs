terraform {
  required_version = ">= 0.15"
  required_providers {
    google = {
    }
    google-beta = {
    }
  }
}

provider "google" {
  region  = var.primary_region
  project = var.gcp_project_id
  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google-beta" {
  region  = var.primary_region
  project = var.gcp_project_id
  scopes = [
    # Default scopes
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",

    # Required for google_client_openid_userinfo
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_project" "project" {
  project_id = var.gcp_project_id
}
