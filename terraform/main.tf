module services {
    source = "../../../../modules/gcp/services"
    project = local.project
    services = local.services
}

module network {
    source = "../../../../modules/gcp/network"
    network = local.network
    subnetwork = local.subnetwork

    #module_depends_on = [module.network.subnetwork]
}

module gke {
    source = "../../../../modules/gcp/gke"
    location = local.location
    project = local.project
    regional = local.regional
    gke = local.gke
    network = local.network
    subnetwork = local.subnetwork

    module_depends_on = [module.router.address]
}

module node_pool {
    source = "../../../../modules/gcp/node_pool"
    location = local.location
    node_pool = local.node_pool
    gke = module.gke.gke

    module_depends_on = [module.gke.gke]
}

module kubernetes_namespaces {
    source = "../../../../modules/kubernetes/namespaces"
    namespaces = local.namespaces

    module_depends_on = [module.node_pool.node_pool]
}

module kubernetes_secrets {
    source = "../../../../modules/kubernetes/secrets"
    secrets = local.secrets

    module_depends_on = [module.kubernetes_namespaces.namespaces, module.service_account.sa_key]
}

module bucket {
    source = "../../../../modules/gcp/buckets"
    project = local.project
    bucket = local.bucket

    module_depends_on = [module.services.services]
}

module push_image {
    source = "../../../../modules/gcp/docker_push"
    docker = local/docker
    module_depends_on = [module.services.services]
}

module artifact_registry {
    source = "../../../../modules/gcp/artifact-registry-repository"
    location = local.artifact_registry.location
    repository_id = local.artifact_registry.repository_id
}