resource google_compute_subnetwork subnetwork {
    provider = google-beta
    name = var.subnetwork.name
    network = google_compute_network.network.self_link
    description = "subnetwork"
    ip_cidr_range = var.subnetwork.instance
    private_ip_google_access = true

    depends_on = [var.module_depends_on]

    log_config {
        aggregation_interval = "INTERVAL_5_MIN"
        flow_sampling = "0.5"
        metadata = "INCLUDE_ALL_METADATA"
    }
}