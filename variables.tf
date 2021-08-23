variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "node_pool_name" {
  #"${google_container_cluster.primary.name}-node-pool"

  default     = "raghav-node-pool"
  description = "region"
}

variable "machine_type" {
  default = "e2-micro"
  #description = "" #TO-DO
}

variable "preemptible_node" {
  default = true
  #description = "" #TO-DO
}

variable "kubernetes_version" {
  default = "1.20.8-gke.900"
  #description
}

variable "autoscaling_min_node_count" {
  default = 2
  #desciption
}

variable "autoscaling_max_node_count" {
  default = 5
  #desciption
}

variable "enable_autoscaling" {
  default = true
  #description
}

variable "auto_repair_node_pool" {
  default = true
  #description
}

variable "auto_upgrade_node_pool" {
  default = true
  #description
}

variable "node_disk_size_gb" {
  default = 10
  #desciption
}

variable "node_disk_type" {
  default = "pd-standard"

  validation {
    condition     = contains(["pd-standard", "pd-balanced", "pd-ssd"], var.node_disk_type)
    error_message = "Invalid node_disk_type selected. Please check configuration for supported values!"
  }

}