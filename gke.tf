# GKE cluster
resource "google_container_cluster" "raghav_cluster" {
  name     = "raghav-gke"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  release_channel {
     channel  = "UNSPECIFIED" 
  } 
}

# Separately Managed Node Pool
resource "google_container_node_pool" "node_pool" {
  name       = var.node_pool_name
  location   = var.region
  cluster    = google_container_cluster.raghav_cluster.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    disk_size_gb = var.node_disk_size_gb
    disk_type    = var.node_disk_type
    preemptible  = var.preemptible_node
    machine_type = var.machine_type
    tags         = [google_container_cluster.raghav_cluster.name, "${var.project_id}-gke", var.node_pool_name]
    metadata = {
      disable-legacy-endpoints = "true"
    }

  }

  version = var.kubernetes_version

  dynamic "autoscaling" {
    for_each = var.enable_autoscaling ? [1] : []

    content {
      min_node_count = var.autoscaling_min_node_count
      max_node_count = var.autoscaling_max_node_count
    }
  }

  management {
    auto_repair  = var.auto_repair_node_pool
    auto_upgrade = var.auto_upgrade_node_pool
  }

}
