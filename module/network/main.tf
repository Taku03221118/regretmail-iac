resource google_compute_network network {
    provider = google-beta
    name = var.network.name
    description = "network"
    auto_create_subnetworks = false
    routing_mode = "REGIONAL"

    depends_on = [
        var.module_depends_on,
    ]
}