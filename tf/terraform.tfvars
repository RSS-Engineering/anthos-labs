gcp_project_id = "rackspace-anthos-testlab1"
primary_region = "us-central1"
primary_zones  = ["us-central1-a"]

secondary_region = "us-west1"
secondary_zones  = ["us-west1-b"]


gcp_service_list = [
  "compute.googleapis.com",
  "iam.googleapis.com",
  "container.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "anthos.googleapis.com",
  "cloudtrace.googleapis.com",
  "meshca.googleapis.com",
  "meshtelemetry.googleapis.com",
  "meshconfig.googleapis.com",
  "iamcredentials.googleapis.com",
  "gkeconnect.googleapis.com",
  "gkehub.googleapis.com",
  "monitoring.googleapis.com",
  "logging.googleapis.com"

]

general_labels = {
  "environment"       = "anthos-lab-test"
  "management_tool"   = "terraform"
  "appid-or-sso"      = "sriram-rajan"
  "tag-std"           = "1-0"
  "needed-until-date" = "2021-12-31"
  "confidentiality"   = "rackspace-confidential"
}

primary_vpc = {
  name             = "primary"
  description      = "primary"
  public_general   = "10.0.0.0/20"
  public_services  = "10.0.16.0/20"
  pod_services     = "10.0.32.0/20"
  private_general  = "10.0.48.0/20"
  private_services = "10.0.64.0/20"
}

secondary_vpc = {
  name             = "secondary"
  description      = "secondary"
  public_general   = "10.1.0.0/20"
  public_services  = "10.1.16.0/20"
  pod_services     = "10.1.32.0/20"
  private_general  = "10.1.48.0/20"
  private_services = "10.1.64.0/20"
}

vcp_flow_log_config = {
  aggregation_interval = "INTERVAL_10_MIN"
  flow_sampling        = 0.5
  metadata             = "INCLUDE_ALL_METADATA"
}

bastion_instance_type = "n1-standard-1"
bastion_os_project    = "ubuntu-os-cloud"
bastion_os_family     = "ubuntu-1804-lts"
bastion_zone          = "b"

gke_cluster_name       = "anthos-primaryt"
gke_version            = "1.18"
gke_logging_service    = "logging.googleapis.com/kubernetes"
gke_monitoring_service = "monitoring.googleapis.com/kubernetes"
gke_master_authorized_networks_config = [
  {
    cidr_blocks = [
      {
        cidr_block   = "0.0.0.0/0"
        display_name = "Allow from everywhere"
      },
    ]
  },
]
gke_service_account_roles = [
  "roles/logging.logWriter",
  "roles/monitoring.metricWriter",
  "roles/monitoring.viewer",
  "roles/stackdriver.resourceMetadata.writer"
]
gke_autoscaling_min_node_count = 1
gke_autoscaling_max_node_count = 2

gke_machine_type = "n1-standard-1"


## SSH
ssh_key_name   = "sri-mb"
ssh_key_public = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA8qZ1W3X+VFSoK8741Pew4B8v7MOhJE9nDAAdMMtzs1xeAmlqs09kqjyIAvRsoeKL/qrLQE2nE/JRpkCOXf99MhdQIeJwXFj3lb1SdIsP7cDuLbtl95EygSjSf5ip+pswJl9BeKRvOPpu5ksX1okoSvXGj2LaTLsFZ1hkzf0S7OHycHRHgpb5v5flzVvCCyW9Vh5WjZHOh8QnNoNWhlA9ljLt/nOIveALxHbHitbX7zirVC0DQqVhwC1d1pHeIbFpLgLoDQV8vghRWyPjPnfS8AyFTs2CEzAnm6UtCEO/Vw1s/UTm9/qHUNS5cRvCn783rvFPQ6motglazv9igvF7cQ=="

