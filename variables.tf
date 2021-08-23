variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "cluster_name" {
  default = "raghav-gke"
  description = "Name of the gke cluster"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "node_pool_name" {
  default     = "raghav-node-pool"
  description = "name of the node pool created in gke cluster"
}

variable "machine_type" {
  default = "e2-micro"
  description = "Type of vm to be provisioned by gke"
}

variable "preemptible_node" {
  default = true
  description = "Controls preemptible nature of the provisioned node for cost reasons"
  #Set this to true since we are on GCP's free trial now
}

variable "kubernetes_version" {
  default = "1.20.8-gke.900"
  description = "Version of kubernetes to be used"
}

variable "autoscaling_min_node_count" {
  default = 2
  description = "Min node count for the autoscaling feature when enabled"
}

variable "autoscaling_max_node_count" {
  default = 5
  description = "Max node count for the autoscaling feature when enabled"
}

variable "enable_autoscaling" {
  default = true
  description = "Controls autoscaling feature configured in gke.tf"
}

variable "vpc_ip_cidr_range"{
  default = "10.10.0.0/24"
  description = "IP Cidr range for the VPC network"
}

variable "auto_repair_node_pool" {
  default = true
  description = "Configure auto repair of nodes if node goes down"
}

variable "auto_upgrade_node_pool" {
  default = true
  description = "Auto upgrade nature of nodes"
  #Tried setting this to false to avoid inadvertent breakage of kubernetes apis but some issue with kubernetes channel
}

variable "node_disk_size_gb" {
  default = 10
  description = "Disk size (in GB) to be provisioned for the nodes in the node pool"
}

variable "node_disk_type" {
  default = "pd-standard"
  description = "Type of disk to be provisioned for the nodes"

  validation {
    condition     = contains(["pd-standard", "pd-balanced", "pd-ssd"], var.node_disk_type)
    error_message = "Invalid node_disk_type selected. Please check configuration for supported values!"
  }

}

variable "alerts_email_id" {
  description = "email id to which alert emails are to be sent by the notification channel"
}