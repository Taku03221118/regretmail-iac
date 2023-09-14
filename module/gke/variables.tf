variable project {
    description = "The name of the project"
}
variable region {
    description = "The name of the bucket"
}

variable location {
    description = "The name of the location"
}

variable network {
    description = "The name of the network"
}

variable subnetwork {
    description = "The name of the subnetwork"
}

variable gke {
    description = "The name of the gke"
}

variable module_depends_on {
    type = any
    default = []
    description = "The name of the module used to be dependencies"
}