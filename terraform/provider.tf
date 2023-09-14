provider google-beta {
    project = local.project
    region = local.region
}

provider google {
    project = local.project
    region = local.region
}

provider kubernetes {
    local_config_file = false
    host = "https://${module.gke.gke.endpoint}"
    cluster_ca_certificate = base64decode(module.gke.gke.master_auth.0.cluster_ca_certificate)
    token = module.gke.google_client_config.access_token
}