### General

variable "gcp_service_list" {
  description = "GCP project services"
  type        = list
}

variable "gcp_project_id" {
  description = "GCP project id"
  type        = string
}

variable "primary_region" {
  description = "Primary Region"
  type        = string
}

variable "primary_zones" {
  description = "Primary Zone"
  type        = list
}

variable "secondary_region" {
  description = "Secondary Region"
  type        = string
}

variable "secondary_zones" {
  description = "Secondary Zone"
  type        = list
}

variable "general_labels" {
  description = "General Labels"
  type        = map
}

variable "ssh_key_name" {
  description = "SSH Key name in AWS"
  type        = string
}
variable "ssh_key_public" {
  description = "SSH Public key"
  type        = string
}

### VPC

# Primary VPC
variable "primary_vpc" {
  description = "All VPC Variables"
  type        = map
}

# Secondary VPC
variable "secondary_vpc" {
  description = "All VPC Variables"
  type        = map
}

variable "vcp_flow_log_config" {
  description = "Whether to enable VPC Flow Logs"
  type        = map
}

### Bastion
variable "bastion_instance_type" {
  description = "Bastion Instance type"
  type        = string
}

variable "bastion_os_family" {
  description = "Bastion OS"
  type        = string
}

variable "bastion_os_project" {
  description = "Bastion OS Project"
  type        = string
}

variable "bastion_zone" {
  description = "Bastion compute zone"
  type        = string
}

### GKE
variable "gke_cluster_name" {
  description = "EKS cluster name"
  type        = string
}
variable "gke_version" {
  description = "K8s version"
  type        = string
}

variable "gke_logging_service" {
  description = "The logging service that the cluster should write logs to"
  type        = string
}

variable "gke_monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to"
  type        = string
}

variable "gke_master_authorized_networks_config" {
  description = <<EOF
  ### example format ###
  master_authorized_networks_config = [{
    cidr_blocks = [{
      cidr_block   = "10.0.0.0/8"
      display_name = "example_network"
    }],
  }]  
EOF
  type        = list(any)
}

variable "gke_service_account_roles" {
  description = "Additional roles to be added to the service account."
  type        = list(string)
}

variable "gke_autoscaling_min_node_count" {
  description = "Min node count"
  type        = number
}

variable "gke_autoscaling_max_node_count" {
  description = "Max node count"
  type        = string
}

variable "gke_machine_type" {
  description = "GCE instance type"
  type        = string
}

### ASM
variable "primary_acm" {
  description = "ACM repo"
  type = map
}
variable "secondary_acm" {
  description = "ACM repo"
  type = map
}


### AWS

# VPC


variable "aws_primary_region" {
  description = "Primary Region"
  type        = string
}

variable "aws_vpc_name" {
  description = "VPC details"
  type        = string
}
variable "aws_vpc_az_count" {
  description = "VPC details"
  type        = string
}
variable "aws_vpc_cidr" {
  description = "VPC details"
  type        = string
}
variable "aws_private_cidr_ranges" {
  description = "VPC details"
  type        = list
}
variable "aws_public_cidr_ranges" {
  description = "VPC details"
  type        = list
}

