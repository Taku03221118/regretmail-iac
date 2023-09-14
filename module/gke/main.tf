resource "google_container_cluster" "primary" {
  provider = google-beta
  name     = var.gke.name
  location = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
  min_master_version = var.gke.version
  network = var.network.self_link
  subnetwork = var.subnetwork.self_link
  default_max_pods_per_node = var.gke.default_max_pods_per_node
  ip_allocation_policy {
    cluster_secondary_range_name = var.subnetwork.secondary_ip_range.0.range_name
    services_secondary_range_name = var.subnetwork.secondary_ip_range.1.range_name
  }
  master_authorized_networks_config {
    dynamic cidr_blocks {
        for_each = [for cidr in var.gke.master_authorized_network :{
            cicd_ip = cidr.cidr_block
            description = cidr.display_name
        }]
        content {
            cidr_block = cidr_blocks.value.cidr_ip
            display_name = cidr_blocks.value.description
        }
    }
  }
  release_channel {
    channel = var.gke.release_channel.channel
  }
  pod_security_policy_config {
    enabled = var.gke.pod_security_policy_config
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  provider = google-beta
  name       = var.node_pool.name
  location   = var.location
  cluster    = var.gke.name
  initial_node_count = 1
  max_pods_per_node = var.node_pool.max_pods_per_node
  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}