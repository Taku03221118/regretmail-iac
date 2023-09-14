variable network {
    description = "The name of the network be created"
}
variable subnetwork {
    description = "The name of the subnetwork be created"
}
variable module_depends_on {
    type = any
    default = []
    description = "The name of the module used to be dependencies"
}